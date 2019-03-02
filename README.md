# Hadoop-CNV-RF: A Scalable Cloud-Based Copy Number Variation Detection Tool  

This is a Hadoop implementation of [CNV-RF](https://www.ncbi.nlm.nih.gov/pubmed/27597741) a 
copy number variation (CNV) detection method capableof detecting clinically relevant CNVs at scale. 
This Hadoop based implementation can rapidly scale to analyze large datasets such as whole-exome 
and whole-genome data. 

### Prerequisites
These instructions assume you have a hadoop cluster up and running with dependency software installed. If you have your own cluster, see [installing dependency software](https://github.com/getiria-onsongo/hadoop-cnvrf-public/wiki/Installing-dependency-software-for-Hadoop-CNV-RF) for instruction on how to install required software. If you are using Amazon's Elastic Map Reduce framework, we provide an image (Amazon Machine Image) with dependency software installed. See [launching hadoop on Amazon using EMR](https://github.com/getiria-onsongo/hadoop-cnvrf-public/wiki/Launching-Hadoop-on-Amazon-using-Elastic-Map-Reduce-Framework) for instructions on launching a Hadoop cluster on Amazon with dependency software installed. 


### Prepare reference genome
If you have used BWA and Bowtie2 before and already have genome indices, create a folder in your master node and save these
indices in that folder. Compress the folder and note the location of this compressed folder. If using an EMR cluster, we recommend 
saving it in /mnt e.g.,  **/mnt/hg19/hg19_index.tar.gz**. 

If you have no experience with BWA and Bowtie2, see  [preparing reference genome](https://github.com/getiria-onsongo/hadoop-cnvrf-public/wiki/Preparing-Reference-Genome) for instruction on indexing the hg19 human genome for BWA and Bowtie2. 


### Installing
Once you have a Hadoop cluster up and running with dependency software installed, get a copy of Hadoop-CNV-RF. If 
using an EMR cluster, navigate to the mounted drive first. The root drive has limited disk space. 

* SSH into your machine. 

```bash
$ ssh -i myPrivateKey.pem hadoop@xxx.us-west-2.compute.amazonaws.com 
```

* Navigate to mounted drive. 
```bash
$ cd /mnt
```

* Get a copy of Hadoop-CNV-RF. 

```bash
$ git clone https://github.com/getiria-onsongo/hadoop-cnvrf-public.git 
```

* Navigate into program folder. 

```bash
$ cd hadoop-cnvrf-public
```

* Navigate into the folder contain test data and uncompress the data. 

```bash
$ cd data/sample/
$ gunzip *.gz
$ cd ../control/
$ gunzip *.gz
```

* Navigate back to program directory. 
```bash
$ cd /mnt/hadoop-cnvrf-public/
```
* Launch the analysis. 
```bash
$ 
./run_script.sh
```

<!--
## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

What things you need to install the software and how to install them

```
Give examples
```

### Installing

A step by step series of examples that tell you how to get a development env running

Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

Explain how to run the automated tests for this system

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

-->

