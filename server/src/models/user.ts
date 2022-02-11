import { Document, Schema, Model, model, Error } from "mongoose";

export interface IUser extends Document {
  username: string;
  password: string;
}

export const userSchema: Schema = new Schema({
  username: {
    type: String,
    unique: true,
    required: true
  },
  password: {
    type: String,
    required: true
  }
});

export const User: Model<IUser> = model<IUser>("User", userSchema);
