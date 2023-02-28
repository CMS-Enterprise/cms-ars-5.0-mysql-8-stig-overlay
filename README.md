# cms-ars-5.0-oracle-mysql-8-stig-overlay

InSpec profile overlay to validate the secure configuration of Oracle MySQL 8 against [DISA's](https://public.cyber.mil/stigs/) Oracle MySQL 8 Benchmark version 1.0.0 tailored for CMS ARS 5.0.

## Getting Started  
### InSpec (CINC-auditor) setup
For maximum flexibility/accessibility, we’re moving to “cinc-auditor”, the open-source packaged binary version of Chef InSpec, compiled by the CINC (CINC Is Not Chef) project in coordination with Chef using Chef’s always-open-source InSpec source code. For more information: https://cinc.sh/

It is intended and recommended that CINC-auditor and this profile overlay be run from a __"runner"__ host (such as a DevOps orchestration server, an administrative management system, or a developer's workstation/laptop) against the target. This can be any Unix/Linux/MacOS or Windows runner host, with access to the Internet.

__For the best security of the runner, always install on the runner the _latest version_ of CINC-auditor.__ 

__The simplest way to install CINC-auditor is to use this command for a UNIX/Linux/MacOS runner platform:__
```
curl -L https://omnitruck.cinc.sh/install.sh | sudo bash -s -- -P cinc-auditor
```

__or this command for Windows runner platform (Powershell):__
```
. { iwr -useb https://omnitruck.cinc.sh/install.ps1 } | iex; install -project cinc-auditor
```
To confirm successful install of cinc-auditor:
```
cinc-auditor -v
```
> sample output:  _4.24.32_

Latest versions and other installation options are available at https://cinc.sh/start/auditor/.

## Specify your BASELINE system categization as an environment variable:
### (if undefined defaults to Moderate baseline)

```
# BASELINE (choices: Low, Low-HVA, Moderate, Moderate-HVA, High, High-HVA)
# (if undefined defaults to Moderate baseline)

on linux:
BASELINE=High

on Powershell:
$env:BASELINE="High"
```

## Inputs: Tailoring your scan to Your Environment

The following inputs must be configured in an inputs ".yml" file for the profile to run correctly for your specific environment. More information about InSpec inputs can be found in the [InSpec Profile Documentation](https://www.inspec.io/docs/reference/profiles/).

### Example Inputs You Can Use

```yaml

# Description: 'database user name'
user: 'SYSTEM'

# Description: 'database password'
password: 'password'

# Description: 'database hostname'
host: '127.0.0.1'

# Description: 'service name'
service: 'ORCLCDB'

# Description: 'Path of sqlplus binary on the runner'
sqlplus_bin: 'sqlplus'

# Description: 'Path of listener.ora on the runner'
listener_file: /opt/oracle/product/19c/dbhome_1/network/admin/listener.ora

# Description: 'Flag to indicate whether the database is multi-tenant or single-tenant'
multitenant: false

# Description: 'Expected version for Oracle database'
version: '19.0.0.0.0'

# Description: 'List of listener interface names defined in listener.ora'
listeners: ['LISTENER']

```

## Running This Overlay Directly from Github

Against a remote target using ssh (i.e., cinc-auditor installed on a separate runner host)
```bash
cinc-auditor exec https://github.com/cms-enterprise/cms-ars-5.0-oracle-mysql-8-stig-overlay/archive/main.tar.gz -t ssh://<username>:TARGET_PASSWORD@TARGET_IP:TARGET_PORT --input-file <path_to_your_input_file/name_of_your_input_file.yml> --reporter=cli json:<path_to_your_output_file/name_of_your_output_file.json> 
```

Against a remote target using a pem key (i.e., cinc-auditor installed on a separate runner host)
```bash
cinc-auditor exec https://github.com/cms-enterprise/cms-ars-5.0-oracle-mysql-8-stig-overlay/archive/main.tar.gz -t ssh://<username>@TARGET_IP:TARGET_PORT -i <PEM_KEY> --input-file <path_to_your_input_file/name_of_your_input_file.yml> --reporter=cli json:<path_to_your_output_file/name_of_your_output_file.json>  
```

Against a _**locally-hosted**_ instance (i.e., cinc-auditor installed on the target hosting the database)

```bash
cinc-auditor exec https://github.com/cms-enterprise/cms-ars-5.0-oracle-mysql-8-stig-overlay/archive/main.tar.gz --input-file=<path_to_your_inputs_file/name_of_your_inputs_file.yml> --reporter=cli json:<path_to_your_output_file/name_of_your_output_file.json>
```

Against a _**docker-containerized**_ instance (i.e., cinc-auditor installed on the node hosting the container):
```
cinc-auditor exec https://github.com/cms-enterprise/cms-ars-5.0-oracle-mysql-8-stig-overlay/archive/main.tar.gz -t docker://<instance_id> --input-file=<path_to_your_inputs_file/name_of_your_inputs_file.yml> --reporter=cli json:<path_to_your_output_file/name_of_your_output_file.json>
```

### Different Run Options

  [Full exec options](https://docs.chef.io/inspec/cli/#options-3)

## Running This Overlay from a local Archive copy 

If your runner is not always expected to have direct access to GitHub, use the following steps to create an archive bundle of this overlay and all of its dependent tests:

(Git is required to clone the InSpec profile using the instructions below. Git can be downloaded from the [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) site.)

When the __"runner"__ host uses this profile overlay for the first time, follow these steps: 

```
mkdir profiles
cd profiles
git clone https://github.com/cms-enterprise/cms-ars-5.0-oracle-mysql-8-stig-overlay.git
cinc-auditor archive cms-ars-5.0-oracle-mysql-8-stig-overlay
cinc-auditor exec <name of generated archive> --input-file=<path_to_your_inputs_file/name_of_your_inputs_file.yml> --reporter=cli json:<path_to_your_output_file/name_of_your_output_file.json>
```

For every successive run, follow these steps to always have the latest version of this overlay and dependent profiles:

```
cd cms-ars-5.0-oracle-mysql-8-stig-overlay
git pull
cd ..
cinc-auditor archive cms-ars-5.0-oracle-mysql-8-stig-overlay --overwrite
cinc-auditor exec <name of generated archive> --input-file=<path_to_your_inputs_file/name_of_your_inputs_file.yml> --reporter=cli json:<path_to_your_output_file/name_of_your_output_file.json>
```

## Using Heimdall for Viewing the JSON Results

The JSON results output file can be loaded into __[heimdall-lite](https://heimdall-lite.cms.gov/)__ for a user-interactive, graphical view of the InSpec results. 

The JSON InSpec results file may also be loaded into a __[full heimdall server](https://github.com/mitre/heimdall2)__, allowing for additional functionality such as to store and compare multiple profile runs.

## Authors
* Eugene Aronne - [ejaronne](https://github.com/ejaronne)

## Special Thanks
* Aaron Lippold - [aaronlippold](https://github.com/aaronlippold)
* Shivani Karikar - [karikarshivani](https://github.com/karikarshivani)

## Contributing and Getting Help
To report a bug or feature request, please open an [issue](https://github.com/cms-enterprise/cms-ars-5.0-oracle-mysql-8-stig-overlay/issues/new).

### NOTICE

© 2018-2022 The MITRE Corporation.

Approved for Public Release; Distribution Unlimited. Case Number 18-3678.

### NOTICE 

MITRE hereby grants express written permission to use, reproduce, distribute, modify, and otherwise leverage this software to the extent permitted by the licensed terms provided in the LICENSE.md file included with this project.

### NOTICE  

This software was produced for the U. S. Government under Contract Number HHSM-500-2012-00008I, and is subject to Federal Acquisition Regulation Clause 52.227-14, Rights in Data-General.  

No other use other than that granted to the U. S. Government, or to those acting on behalf of the U. S. Government under that Clause is authorized without the express written permission of The MITRE Corporation.

For further information, please contact The MITRE Corporation, Contracts Management Office, 7515 Colshire Drive, McLean, VA  22102-7539, (703) 983-6000.

### NOTICE 

Defense Information Systems Agency (DISA) STIGs are published at: https://public.cyber.mil/stigs/
