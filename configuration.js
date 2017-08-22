module.exports = {
    mlabDBToClone: process.env.Mongo_Base,
    mlabDB: process.env.Mongo_Base,
    mlab_migration: process.env.Mongo_Base,
    saveLock: false,
    addLock: false,
    secret: process.env.JWT_TOKEN,
    https: "force",
    mlab_token: process.env.mlab_token,
	configMongo: {
		'driver': "mongoose",
		'database': "semantic_bus_prod",
		'url': 'mongodb://alex:alexfoot31@ds131362-a0.mlab.com:31362,ds131362-a1.mlab.com:31362/semantic_bus_prod?replicaSet=rs-ds131362',
		'password': process.env.MLAB_PASSWORD,
		'username': process.env.MLAB_USERNAME
	},
	googleAuth : {
        'clientID'      : process.env.clientID_GOOGLE ,
        'clientSecret'  : process.env.client_GOOGLE_Secret,
        'callbackURL'   : '/auth/'
    }
}

