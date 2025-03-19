function fn() {
    karate.configure('connectTimeout', 200000);
    karate.configure('readTimeout', 200000);
    karate.configure('ssl', true);

    const env = karate.env;

    const config = {
        env: env,
        application: 'application/x-www-form-urlencoded',
        clientSecret: karate.properties['secret']
    };

    const config2 = karate.callSingle('classpath:features/setup.feature');

    const endPoints = {
        baseUrl: 'https://assesmenttorneos.onrender.com',
    };

    const paths = {
        usuarios: '/usuarios/',
        torneos: "/torneos"
    };
    Object.assign(config, endPoints, paths, config2);

    return config;
}
