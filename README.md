## Getting Started Capybara, Cucumber, Rspec, Selenium, Rake, SitePrism ##

## Steps by Steps:
### 1. Download Project
```shell
git clone https://github.com/reinaldorossetti/automationpractice.git
cd automationpractice
```

### 2. Installing gems
To install All gems:
```shell
bundle install
```

### 3. Download Driver:
Install and include in PATH
- [chromedriver](https://sites.google.com/a/chromium.org/chromedriver/)
<br> or install gem chromedriver-helper
```shell
gem install chromedriver-helper
```
### 4. Test Data Mass:
### data.csv
The mass of data is not in the feature for good practice but in a cvs file, need the data.csv inside the path "features / data / data.csv".
<br>**Content of data.csv:**  
your_email_address,password,fist_name,last_name,date_of_birth_XX/XX/XXXX,company_name,address,Virginia Beach,city_name,zip_code,United States,mobile_number_19911110000,home

###

### 5. Run Tests: 
### Run tests in DEV with Chrome
Type this in the tests folder:
```shell
bundle exec cucumber  -p ci -p html -p headless -p dev
```

### Run tests in DEV with headless
Type this in the tests folder:
```shell
bundle exec cucumber  -p ci -p html -p headless -p dev
```

### Run tests in HMG with Chrome
Type this in the tests folder:
```shell
bundle exec cucumber -p pretty -p html -p no_headless -p hmg
```

### Run tests in HMG with headless
Type this in the tests folder:
```shell
bundle exec cucumber -p ci -p html -p headless -p hmg
```

### Run with tags
Type this in the tests folder:
```shell
bundle exec cucumber --tags @run
```

### RakeFile - of reduced form we can use rake framework.
Type this in the tests folder:
```shell
rake test_chrome_dev
```

```shell
rake test_chrome_dev_headless
```

```shell
rake test_chrome_hmg
```
```shell
rake test_chrome_hmg_headless
```

#### Pre-conditions:

    Ruby 2.3.3 or 2.4.4
    Navegador Chrome Updated
    chromedriver
    Gems do ruby (Gemfile)
    CSV File of mass.


### Basic Structure Project:

**Specfications:** Where is the functionality of the project.

**Steps Definitions:** Where the actual tests are performed.

**Pages:** Where the elements and methods of a particular page are mapped.

**Support:** Where is the project settings.

**Results:** Where is the result of the tests and reports.

**Data:** Mass of Data for tests.

 **Framework:** The framework folder contains classes or modules with global functions to reduce code in Pages.


### Basic BDD:
Cucumber executes executable specifications written in plain language and produces reports indicating whether the software behaves according to the specification or not.
- **Feature** The purpose of the Feature keyword is to provide a high-level description of a software feature, and to group related scenarios.
- **Scenario** is a written example to illustrate a specific aspect of application behavior.
- Each step starts with Given, When, Then, And, or But. 
- **Given** steps are used to describe the initial context of the system.  
- **When** steps are used to describe an event, or an action.  
- **Then** steps are used to describe an expected outcome, or result.  
- **And, But** use If you have several Given’s, When’s, or Thens.
- **Data Tables** are handy for passing a list of values to a step definition.

**To know if your bdd is long, it should contain up to 5 steps of the same type.**


**Logs:**  
In computing, data logging is an expression used to describe the process of recording relevant events in a computer system.  

- Generates Cucumber HTML Report with logs.  
- Get the browser and Selenium logs.  

#### References:  
https://docs.cucumber.io/gherkin/reference/  
https://github.com/teamcapybara/capybara  
https://github.com/natritmeyer/site_prism  
https://github.com/ruby/rake
