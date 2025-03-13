# local-ssl-certifier

A tool to enable HTTPS on your localhost using `mkcert`. This package provides an easy way to create SSL certificates for local development.

## Prerequisites

Before using this package, ensure that you have the following installed on your machine:

- [Node.js](https://nodejs.org/) (version 12 or higher)
- [npm](https://www.npmjs.com/get-npm)

## Installation

To install `local-ssl-certifier`, run the following command:

```bash
npm install -g local-ssl-certifier
```

This installs the package globally, making the `local-ssl-certifier` command available in your terminal.

## Usage

To use this tool, run the following command:

```bash
local-ssl-certifier
```

The script will prompt you to enter the domain for which you want to generate an SSL certificate, such as `subdomain.localhost` for a subdomain or `localhost` for localhost.


### Generated Files

The generated SSL certificates will be placed in an `ssl` directory created in the same directory where you ran the command.

## Examples of uses

### Express


To enable HTTPS for your Express application, follow these steps:

1. **Generate SSL Certificates**: Use the local-ssl-certifier command to generate SSL certificates as mentioned previously.

2. **Configure your https server**: Update your index.ts file to include the SSL configuration.

```typescript
import express from 'express';
import https from 'https';
import fs from 'fs';
import path from 'path';

const app = express();
const env = {
    SERVER_PORT: 3000 // Specify your server port
};

// Load the generated SSL certificates
const key = fs.readFileSync('ssl/localhost-key.pem');
onst cert = fs.readFileSync('ssl/localhost.pem');

// Create HTTPS server
https.createServer({ key, cert }, app).listen(env.SERVER_PORT, () => {
    console.log(`Server is running on https://localhost:${env.SERVER_PORT}`);
});

```

### Angular

To enable HTTPS for your Angular application, follow these steps:

1. **Generate SSL Certificates**: Use the local-ssl-certifier command to generate SSL certificates as mentioned previously.

2. **Configure Angular**: Update your angular.json file to include the SSL configuration for the development server. You can do this by adding or modifying the "serve" options as follows:

```json
{
  "projects": {
    "your-angular-app": {
      ...
      "architect": {
        "serve": {
          "options": {
            "ssl": true,
            "sslKey": "ssl/subdomain.localhost-key.pem",
            "sslCert": "ssl/subdomain.localhost.pem",
            ...
          }
        },
        ...
      }
    }
  }
}

```

3. **Run Your Angular Application**: Now you can run your Angular application with HTTPS by using the Angular CLI command:

```bash
ng serve
```

Your application should now be accessible via HTTPS at `https://subdomain.localhost:4200` or the port specified in your configuration.

## Contribution

Contributions are welcome! If you have suggestions for improvements or if you would like to fix bugs, feel free to open a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Author

- **Tom Frenois**
