import { Schema, model } from 'mongoose';
import * as bcrypt from 'bcrypt';
import * as jwt from 'jsonwebtoken';

const SALT_ROUNDS = 10;

export interface IUser {
  _id: string;
  fullname?: string;
  email?: string;
  password?: string;
  validatePassword?: (password: string) => Promise<boolean>;
  generateAuthToken?: () => Promise<string>;
  weights?: {
    timestamp: string;
    value: number;
  }[];
}

const UserSchema = new Schema<IUser>({
  email: { type: String, required: true },
  fullname: { type: String, required: true },
  weights: { type: [], required: true },
  password: { type: String, required: true },
});

//Before new user is saved on databse, hash password
UserSchema.pre('save', async function (next: any) {
  const _user = this as IUser;

  if (!this.isModified('password')) return next();

  try {
    _user.password = await bcrypt.hash(this.password, SALT_ROUNDS);

    return next();
  } catch (e) {
    return next(e);
  }
});

//Compare user password in sign_in payload
UserSchema.methods.validatePassword = async function (password: string) {
  return await bcrypt.compare(password, this.password);
};

//Signs JWT adds user uid and fullname
UserSchema.methods.generateAuthToken = async function () {
  const user = this as IUser;

  const token = jwt.sign(
    { uid: user._id, fullname: user?.fullname },
    process.env.JWT_ACCESS_TOKEN,
    {
      expiresIn: '5h',
    }
  );

  return token;
};

export const UserModel = model('User', UserSchema);
