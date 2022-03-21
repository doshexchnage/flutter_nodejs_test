const logout = async (req, res) => {
    try {

      req.logout();
      res.redirect("/");

      res.cookie('token', `${process.env.JWT_SECRET}`, { httpOnly: true, sameSite: 'None', secure: true, maxAge: 1 });
      
      res.status(200).json({success: true});
    } catch (error) {
      return res.status(400).json(error);
    }
  };
  
  module.exports = { logout };
  