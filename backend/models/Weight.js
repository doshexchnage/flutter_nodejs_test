const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const weightSchema = new Schema({
    current_weight: {
      type: String,
      required: true,
    },
    updated_at: {
      type: Date,
      default: Date.now,
    },
    created_at: {
      type: Date,
      default: Date.now,
    },
    created_by: {
      type: Schema.Types.ObjectId,
      ref: "User",
    },
    updated_by: {
      type: Schema.Types.ObjectId,
      ref: "User",
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("Weight", weightSchema);
