// const jwt = require("jsonwebtoken");
// const auth = async(req,res,next)=>{
//     try{
//         const token = req.header("x-auth-token");
//         if(!token)
//         // console.log('token=null');
//         return res.status(401).json({msg:"no auth token specified"});

//         const verified = jwt.verify(token,"passwordKey");
//         if(!verified)
//         return res.status(401).json({msg:"You are not authorised"});

//         req.user=verified.id;
//         req.token=token;
//         next();
//     }catch(e){
//         console.log(e.message);
//         res.status(500).json({msg:e.message});
//     }
// }

// module.exports=auth;
const jwt = require("jsonwebtoken");

const auth = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");

    if (!token)
      return res.status(401).json({ msg: "No auth token, access denied." });

    const verified = jwt.verify(token, "passwordKey");

    if (!verified)
      return res
        .status(401)
        .json({ msg: "Token verification failed, authorization denied." });

    req.user = verified.id;
    req.token = token;
    next();
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
};

module.exports = auth;