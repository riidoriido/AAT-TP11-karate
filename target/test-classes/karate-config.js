function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
   baseUrl: 'https://api.clockify.me/api/v1',
   token:'ZjdkMjY5MmEtNGM1MS00ZTdiLTlmNzAtYjA4YmEyY2Q3OGVk'
  }
  if (env == 'dev') {
  } else if (env == 'e2e') {
  }
  return config;
}