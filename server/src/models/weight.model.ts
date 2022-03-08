import { Schema, model } from 'mongoose';

export interface IWeight {
  uid: string;
  value: number;
  timestamp: string;
}
export interface IUserWeight {
  uid: string;
  userUid: string;
  weights?: IWeight[];
}

const WeightSchema = new Schema<IUserWeight>({
  uid: { type: String },
  userUid: { type: String, required: true },
  weights: { type: [], required: true },
});

export const WeightModel = model('Weight', WeightSchema);
