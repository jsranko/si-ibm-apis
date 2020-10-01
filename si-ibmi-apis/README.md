# SI - IBM i Apis Framework

SIIIA Framework tries to reduce the complexity of the system apis to capsule and thereby provide a simple usable modules/serviceprograms. 

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

OpenSource path must be present in PATH

```
export PATH=/QOpenSys/pkgs/bin:$PATH
```

### Installing

A step by step series of examples that tell you how to get a development env running

Get a setup script

```
/QOpenSys/pkgs/bin/wget https://raw.githubusercontent.com/jsranko/si-ibm-apis/master/si-ibmi-apis/QSHSRC/setup.sh --no-check-certificate
```

Run setup script

```
bash setup.sh
```

Clone the project repository

```
git config --global http.sslVerify false
git clone https://github.com/jsranko/si-ibm-apis.git
```

Go to project directory
```
cd si-ibm-apis/si-ibmi-apis/
```

### Configuration

Configure project before it is created 

```
{
	"library": "SIIIA",
	"job_ccsid": "037",
	"pase_ccsid": "1208"
}
```

## Build

Build with GNU Make
```
gmake
```

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc
