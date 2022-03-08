import { ValidateAuthPayload } from '../helpers';
import { IAuthPayload } from '../interfaces';
import { UserModel } from '../models';

export async function Login(payload: IAuthPayload) {
  let error;

  error = await ValidateAuthPayload(payload);

  if (error) return { validationError: true };

  const user = await UserModel.findOne({ email: payload.email });
  const validPassword = user && (await user.validatePassword(payload.password));

  if (!user || !validPassword) {
    return { invalidCredentials: true };
  }

  //Create JWT token
  const token = await user.generateAuthToken();

  return { token };
}

export async function Register(payload: IAuthPayload) {
  await ValidateAuthPayload(payload);

  const exist = await UserModel.exists({ email: payload.email });

  if (exist) return { exist: !!exist };

  const newUser = new UserModel({
    email: payload.email,
    fullname: payload.fullname,
    password: payload.password,
  });

  newUser.save();
  return { success: true };
}

export async function GetUsers(payload: IAuthPayload) {
  return await UserModel.find();
}

export async function GetUserWhere(payload: { [key in string]: any }) {
  return await UserModel.findOne({ ...payload });
}

export async function PurgeUsers(payload: IAuthPayload) {
  return await UserModel.deleteMany();
}
