const cloudinary = require("cloudinary").v2;
const fs = require("fs");
require("dotenv").config();

class ImageService {
  static async uploadOnCloudinary(localFilePath) {
    try {
      cloudinary.config({
        cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
        api_key: process.env.CLOUDINARY_API_KEY,
        api_secret: process.env.CLOUDINARY_API_SECRET,
      });

      if (!localFilePath) {
        return null;
      }

      const response = await cloudinary.uploader.upload(localFilePath, {
        resource_type: "auto",
      });
      // const response = await cloudinary.

      console.log("File uploaded successfully!", response.url);
      console.log(response);
      fs.unlinkSync(localFilePath);

      return response;
    } catch (error) {
      //remove locally saved file as upload is failed
      fs.unlinkSync(localFilePath);
      console.log(error);
      return null;
    }
  }
}
module.exports = ImageService;
