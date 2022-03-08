import * as Joi from 'joi';

export const ValidateAuthPayload = async (payload: {
  email: string;
  password: string;
}) => {
  const schema = Joi.object({
    fullname: Joi.string(),
    password: Joi.string().min(6),
    email: Joi.string().email({
      minDomainSegments: 2,
    }),
  });

  try {
    await schema.validateAsync(payload);
    return null;
  } catch (error) {
    return error;
  }
};
