import { Document, Schema, Model, model, Error } from "mongoose";

export interface IWeight extends Document {
  userID: String;
  weight: Number;
  created_date: Date;
}

export const weightSchema = new Schema({
  userID: {
    type: String, 
    required: true
  },
  weight: {
    type: Number, 
    required: true
  },
  created_date: {
    type: Date, required: false,
    default: Date.now
  }
});



export const WeightEntry: Model<IWeight> = model<IWeight>("WeightEntry", weightSchema);