const EventService = require("../services/event.services.js");
const UserModel = require("../models/user.models.js");
const ImageService = require("../services/cloudnary.js");

exports.createEvent = async (req, res) => {
  try {
    const {
      EventId,
      EventName,
      EventCategory,
      EventContent,
      EventLink,
      EventStart,
      EventDeadline,
      EventImage,
      EventFees,
      EventTime,
      EventVenue,
    } = req.body;

    const Admin = req.user._id;

    //constraint check
    if (
      [EventName, EventCategory, EventContent, EventLink, EventTime].some(
        (feilds) => feilds?.trim() == " "
      )
    ) {
      throw new Error("All fields are required");
    }

    //check for files input

    const imagePath = req.file?.path;

    if (!imagePath) {
      throw new Error("Image is required");
    }
    console.log(imagePath);

    //upload on cloudinary
    const image = await ImageService.uploadOnCloudinary(imagePath);
    // console.log(image);
    if (!image) {
      throw new Error("Image is not retrieved");
    }

    let eventdetails = await EventService.createEvent(
      EventId,
      EventName,
      EventCategory,
      EventContent,
      EventLink,
      EventStart,
      EventDeadline,
      EventFees,
      image.url,
      EventTime,
      EventVenue
    );

    // const createdEvent = await UserModel
    // .findById(user._id)

    // if(!createdEvent)
    // {
    //     throw new Error("Something went wrong !");
    // }

    res.json({ status: true, success: eventdetails });
  } catch (error) {
    throw error;
  }
};

// export{createEvent}; F:\pict-clubhub-master\pict-clubhub-master\backend-2-app\images\Screenshot 2024-04-05 195528.png
