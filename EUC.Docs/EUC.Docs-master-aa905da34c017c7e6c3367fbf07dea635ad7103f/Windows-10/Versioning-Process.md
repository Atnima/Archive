

# Purpose
This article is intended to articulate the versioning standards to be utilised for the next generation MOE builds. Providing a consistent versioning numbering system will allow greater automation and certainity during development, deployment and testing.

# Existing Standards
Rather than re-invent the wheel, the definition provided by [Semantic Versioning 2.0.0](http://semver.org/) scheme will for the basis of this standard.

The key points from the specification are:

  > (2) A normal version number MUST take the form X.Y.Z where X, Y, and Z are non-negative integers, and MUST NOT contain leading zeroes. X is the major version, Y is the minor version, and Z is the patch version. Each element MUST increase numerically. For instance: 1.9.0 -> 1.10.0 -> 1.11.0.

  > (3) Once a versioned package has been released, the contents of that version MUST NOT be modified. Any modifications MUST be released as a new version

  > (10) Build metadata MAY be denoted by appending a plus sign and a series of dot separated identifiers immediately following the patch or pre-release version

# Source Image Standards

* MAJOR = completely different operating system
* MINOR = change to the reference image task sequence (for examaple, the addition of package which would likely result in automated tests failing)
* PATCH = security patches only added to the reference image
* metadata = identified by the `+` character and should note the type of WIM image and the build date

Multiple builds on the same day must have the version number incremented. Metadata is just reference information, it should not help determine the latest version at all. Details about each version number change should be stored in the relevant article.

## Assignment
The following major versions are assigned to the current known operating systems:

* 1.n.n series for Windows 7 Enterprise x64 with SP1 
* 2.n.n series for Windows 8.1 Enterprise __x64__ with Update 1 and above
* 3.n.n series for Windows 8.1 Enterprise __x86__ with Update 1 and above
* 4.n.n series for Windows 10 Enterprise x64 Technical Preview
* 5.n.n series for Windows Server 2008 R2 with IE8
* 6.n.n series for Windows Server 2008 R2 with IE9
* 7.n.n series for Windows Server 2008 R2 with IE10
* 8.n.n series for Windows Server 2012 R2 with IE11
* 9.n.n series for Windows 10 Enterprise x86
* 10.n.n series for Windows 10 Enterprise x64

\\m562prd1\mdt-win81$\Captures

## Examples

Version Number | Description
--- | ---
2.0.0+source.2014-12-09  | The initial release of the source image

# Reference Image Standards

* MAJOR = completely different operating system
* MINOR = change to the reference image task sequence (for examaple, the addition of package which would likely result in automated tests failing)
* PATCH = security patches only added to the reference image
* metadata = identified by the `+` character and should note the type of WIM image and the build date

Multiple builds on the same day must have the version number incremented. Metadata is just reference information, it should not help determine the latest version at all. Details about each version number change should be stored in the relevant article.

## Assignment
The following major versions are assigned to the current known operating systems:

* 1.n.n series for Windows 7 Enterprise x64 with SP1 
* 2.n.n series for Windows 8.1 Enterprise __x64__ with Update 1 and above
* 3.n.n series for Windows 8.1 Enterprise __x86__ with Update 1 and above
* 4.n.n series for Windows 10 Enteprise x64 Technical Preview

## Examples

Version Number | Description
--- | ---
2.0.0+refimage.2014-09-01  | The initial release of the reference image
2.0.1+refimage.2014-10-12  | A month later, security patches were added to the reference image
2.1.0+refimage.2014-11-14  | A month later, a change to the reference image task sequence was made

# Operating System Deployment Standards

* MAJOR = completely different operating system
* MINOR = change to the tier 1 packages installed during the deployment task sequence, including driver packs
* PATCH = security updates applied (either through WSUS or new base image)
* metadata = identified by the `+` character and should note the type of OSD task sequence and creation date

Multiple edits on the same day must have the version number incremented. Metadata is just reference information, it should not help determine the latest version at all. Details about each version number change should be stored in the relevant article.

## Assignment
The following major versions are assigned to the current known operating systems:

* 1.n.n series for Windows 7 Enterprise x64 with SP1 
* 2.n.n series for Windows 8.1 Enterprise __x64__ with Update 1 and above
* 3.n.n series for Windows 8.1 Enterprise __x86__ with Update 1 and above
* 4.n.n series for Windows 10 Enteprise x64 Technical Preview

## Examples

Version Number | Description
--- | ---
2.0.0+osd.2014-09-01 | The initial release of the reference image
2.0.1+osd.2014-10-12 | A month later, security patches were added to the reference image WIM file
2.1.0+osd.2014-11-14 | A month later, security patches were added to the reference image WIM file and a new version of Java was added
