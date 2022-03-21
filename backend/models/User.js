const mongoose = require("mongoose");
const Schema = mongoose.Schema;
const bcrypt = require("bcrypt");

const userSchema = Schema({
    name: {
      type: String,
      trim: true,
      required: true,
    },
    email: {
      type: String,
      required: [true, "Please provide your email"],
      unique: true,
      lowercase: true,
    },
    password: {
      type: String,
      required: [true, "Please enter a valid password"],
      minlength: [6, "Minimum password length is 6 characters"],
    },
    weight: [
      {
        type: Schema.Types.ObjectId,
        ref: "Weight",
      },
    ],
  },
  { timestamps: true }
);

userSchema.pre("save", async function (next) {
  const salt = await bcrypt.genSalt(10);
  this.password = await bcrypt.hash(this.password, salt);
  next();
});

// userSchema.statics.login = async function (email, password) {
//   const user = await this.findOne({ email });

//   if (!user) {
//     throw Error("incorrect email");
//   }

//   const auth = await bcrypt.compare(password, user.password);
//   if (!auth) {
//     throw Error("incorrect password");
//   }
//   return user._id;
// };

module.exports = mongoose.model("User", userSchema);
