---
title: Qualtrics Survey Platform with Recruitment via MTurk
author:
  - Jonathon Baron
  - Molly Offer-Westort
date: 2017-1-18
bibliography: mturk.bib
---

# Using the Qualtrics Survey Platform with Recruitment via MTurk

This document provides recommendations for researchers conducting studies using the Qualtrics survey platform, with recruitment via Amazon Mechanical Turk (MTurk). These recommendations should serve as default practices, and cover pre-planning, design checks in both the Qualtrics and MTurk platforms, several stages of testing, and protocols for resolving issues after launching a flawed study.

This document also contains a number of example images and `R` code.

## *Pre-planning*
All survey experiments to be carried out in Qualtrics using MTurk should first proceed through the following pre-planning stages:

### Presentation/discussion.
A draft of the survey instrument(s) should be presented to a senior colleague or professor with experience running surveys in Qualtrics using MTurk. When conducting research as part of a research lab, drafts should be presented before the lab, with PI(s) present.

### IRB exemption/approval.
Following presentation or workshopping, the amended instrument(s) must receive IRB exemption/approval. For research conducted with coauthors affiliated with separate institutions, researchers must receive IRB exemption/approval from each institution.

### Pre-analysis plan.
Development and archiving of a pre-analysis plan (PAP) prior to data collection is recommended. Online registries include the Evidence in Governance and Politics (EGAP) [registry](http://egap.org/register-your-design) and the American Economic Association's [registry](https://www.socialscienceregistry.org/) for randomized controlled trials (AER RCT). In general, it is recommended that the researcher follow the Standard Operating Procedures for the Green Lab at Columbia University (@lin2015standard) for analysis of experiments.



## *Qualtrics survey design*
The survey, hosted via a Secure Qualtrics platform, should satisfy the following design requirements and checks before it can be launched:

### Independent confirmation

This includes basic proofreading as well as language considerations: the survey should be free of spelling and grammar errors, and instructions and questions should be worded succinctly and clearly. Questions should be formatted efficiently and readably; for example, separate questions with the same response options can be condensed in the Matrix Table format.

The first question should be a consent form; updated templates for consent forms are available at the website of the [Yale Human Research Protection Program](https://your.yale.edu/research-support/human-research).

For all "covariate" questions with appropriate analogues in the ANES (or online-formatted pseudo-ANES) survey instrument, it is recommended that the researcher use questions matching those specifications.

At this stage, it is essential to ensure that survey questions aim at the appropriate inferential target, and that answer choices allow for clear measurement of the outcome of interest. A PAP may be helpful in determining if this is the case. When in doubt, the research should consult the established literature in the field for proper terminology, as well as with colleagues familiar with the topic. If there is no clear consensus, randomization of question wording or response options may be useful in testing.

### Survey Flow
#### Randomization.
When randomizing elements, *do not* select "Evenly Present Elements"; it is recommended that the researcher instead employ simple random assignment, because the precise algorithm underlying the "Evenly Present Elements" option is unknown.

* "Evenly Present Elements" is intended to implement repeated complete random sampling without replacement. Elements are selected for presentation randomly, without replacement until each element has been presented once; this process is then repeated so that no element can be presented more than once more than any other element at any time.
* The precise algorithm is unknown, so it is recommended that the researcher avoid this option.

Meanwhile, *do* ensure that the Randomizer is set to present the correct number of elements to respondents. Ensure, as well, that other design features (e.g., branching) remain unchanged across randomized arms, where appropriate.

![Randomizer Example](mturk/mturk/randomizer.jpg)

In the case of randomizing answer-choice ordering (e.g., when randomly reversing question order), the researcher may use one of the following options:

* Create two or more versions of the relevant question, and randomly assign respondents to view one version.
	* Confirm that answer-choice codings are held constant across each permutation (i.e., irrespective of question/answer order, a given selection should always be represented with the same numeric code).
		* If answer-choice codings are not properly coded prior to survey implementation, recode answer choices accordingly before downloading the resulting data; the Qualtrics system automatically updates the data file to accommodate the recoded choices.
* Click on the Advanced Question Options gear symbol on the left of the question to incorporate randomization, then click Randomization in the drop-down menu. For more complex randomization schemes (i.e., beyond randomizing the order of all answer choices, the functionality for which is provided by choosing "Randomize the order of all choices"), click the "Set Up Advanced Randomization" hyperlink next to the "Advanced Randomization" option; the order of specific questions can be randomized, while maintaining the order of other questions (e.g., in a question with four answer choices, the ordering of the first two answer choices can be randomized, while the third and fourth answer choices will always appear, respectively, as the third and fourth options).
* [Alternative implementations](https://gist.github.com/marketinview/2a7172dd9c599f83ca45) using JavaScript are also available.

For further recommendations, consult [Randomized Variables](#randomized-variables).

#### Branching.
Ensure that branching is specified correctly (e.g., conditioned on the correct question/answer choice pair(s), embedded data, and randomization). In the case of random assignment into a given treatment arm via branching, ensure that the respondent views the only relevant arm(s), and  that branching does not present all arms sequentially.

#### Embedded data.
When embedded data is randomized, for example to store treatment arm assignment, this should be completed at the beginning of the survey to the extent possible (see [Randomization](#randomization)). End-of-survey confirmation codes are a notable exception.

If piped text is used, the researcher should confirm that the text is formatted adequately and is grammatically correct.

#### Quotas.
Quotas may not perform as desired when many respondents begin taking the survey at the same time, as is often the case on MTurk. It is therefore recommended that the researcher take special care when using quotas. If possible, subjects should be assigned to treatment arms by randomization and branching (see [Randomization](#randomization) and [Branching](#branching)); if they must be used, quotas should be carefully monitored in piloting and distribution stages (see [Piloting](#piloting) and [Full distribution](#full-distribution)).

#### End-of-survey.
At each point in the survey when respondents may be deemed ineligible to continue (based on consent, recruitment requirements, etc.), survey flow should direct ineligible respondents to an End-of-survey element. These elements can be customized using stored messages in the Qualtrics Library, so that respondents who end the survey prior to completion are not presented with an end-of-survey confirmation code for entry into MTurk.

![End of Survey Message Example](mturk/mturk/end_of_survey_message.jpg)

End-of-survey confirmation codes can be generated immediately prior to the final End-of-survey element using a Web Service element, as below.

![Web Service Example](mturk/mturk/web_service.jpg)

Respondents who complete the survey should then receive an End-of-survey messages such that the confirmation code is piped into the message. Ensure that the Embedded Data term "called" in the Web Service element matches that defined in the message written and stored in the Qualtrics Library (see above image).

![End of Survey Example](mturk/mturk/eos.jpg)

#### Anonymization.
Survey responses must be anonymized in accordance with IRB exemption/approval. Responses can be anonymized by checking the appropriate box in Survey Options &rarr; Survey Protection, as below.

![Anonymization Example](mturk/mturk/anonymize.jpg)

* Follow-up surveys. Follow-up surveys should always include either or both of the following elements, in confirmed working order:
	* An IRB-exempt/approved question or questions for matching respondents between waves.
	* Data collection enabling matching between waves (e.g., via Qualtrics confirmation code).

#### Validation.
Each survey question should feature appropriate validation using Validation Options (e.g., Request Response, or Custom Validation for various input formats). Validation options can be selected on the right pane containing question options, after selecting a given question in the Qualtrics platform.


#### Survey testing
* Alpha testing. In alpha-testing, all attempts should be made to "break" the survey functionality, especially with conditional embedded data, validation, and input text.

	Each coauthor should test the survey in its entirety using either the Preview Survey functionality or the Anonymous Link for web distribution. Both approaches record survey responses.

	If research assistants are collaborating on the project, they should be allowed full access to the survey in order to review the survey instrument and flow. The primary researcher(s) may choose to copy the survey prior to sharing to research assistants, to avoid accidental changes or errors. Alternatively, if a research assistant is unavailable, the primary researchers should seek the assistance of external collaborators who were neither involved in creating the survey instrument, nor directly involved in the broader research project; this approach aims to minimize the potential for bias preventing the discovery of design flaws.

	Test Responses (Tools &rarr; Test Survey) allow for computer-generated responses to all survey questions; depending on the complexity of survey flow and number of treatment arms, researchers may wish to collect twice as many test responses as intended human survey responses (using Test Responses, approximately half will fail the consent question).

	Examine potential issues and data structure by downloading data via Data & Analysis (using legacy format). Ensure that survey flow is functioning properly, and all data necessary for analysis will be collected.

* Beta testing. When conducting research as part of a research lab, surveys should be "beta tested" with lab members using the Anonymous Link for web distribution. Instruct lab members to also attempt to "break" the survey functionality, especially with conditional embedded data, validation, and input text. When employing randomization, request that lab members record which treatment(s) they receive, to confirm proper randomization pursuant to evaluations using Test Responses.

	Again, examine potential issues and data structure by downloading data via Data & Analysis (using legacy format).


## *Integration with MTurk*

### MTurk HIT specification

Once the Qualtrics survey is in concordance with the checklist items enumerated in [Pre-Planning](#pre-planning), an MTurk HIT must be created and designed appropriately.

#### Create a new HIT
* Navigate to the "Create" tab at the navigation bar at the top of the MTurk Requester page.

* If not employing an MTurk default format, select "Other" from the format list on the left; then select "Create Project."

![Create HIT Example](mturk/mturk/create_hit.jpg)

* Specify requirements for "Describe your HIT to Workers":

	![Describe HIT Example](mturk/mturk/describe_hit.jpg)

	1. Specify a "HIT Title."
	2. Specify a short "HIT description."
	3. Specify appropriate "Keywords" pertaining to the HIT.

* Specify requirements for "Setting up your HIT":

	![Setting Up Your HIT Example](mturk/mturk/setting_up_your_hit.jpg)

	1. Specify "Reward per assignment" (i.e., the payment rate, per subject).
	2. Specify "Number of assignments per HIT" (for a survey or survey experiment, this will correspond to the number of subjects to be recruited for the pilot or study---see [Piloting](#piloting) for further details; $.50/5 minutes is recommended).
	3. Specify "Time allotted per assignment" (1 Hours is recommended as a default).
	4. Specify time for "HIT expires in" (5 Days is recommended as a default).
	5. Specify time for "Auto-approve and pay Workers in" (8 Hours is recommended as a default).

* Specify "Worker requirements."

	![Worker Requirements Example](mturk/mturk/worker_requirements.jpg)

	1. *Do not* "Require that Workers be Masters to do your HITs.
		* Masters are not required for quality tasks, but cost appreciably more than standard MTurk workers.
	2. "Specify any additional qualifications Workers must meet to work on your HITs" (up to five may be set).
		* Set "Location is UNITED STATES (US)," or other location as appropriate and exempt/approved by IRB.
		* "HIT Approval Rate (%) for all Requesters' HITs greater than or equal to 95," or a different threshold as appropriate for the task (a higher HIT Approval Rate is recommended for higher-quality responses).
		* "Number of HITs Approved" to "greater than or equal to 50."
		* Specify whether the "Project contains adult content."
		* Set "HIT Visibility" to "Hidden" - Only Workers that meet my HIT Qualification requirements can see and preview my HITs.
	3. For follow-up surveys:
		* Remove "HIT Approval Rate" and "Number of HITs Approved" qualifications.
		* Include additional qualification type based on Worker ID collected in the preceding wave(s).
		* Qualifications can be assigned using `MTurkR`, which may also be used to recontact workers.

* Specify Design Layout:
	1. Paste and format study description into the "Design Layout" editor (the appended [default format](##mturk-hit-default-format-html-code) is recommended; click the "Source" button and paste the entirety of the below HTML code into the editor).
	2. Ensure that the Anonymous survey link URL directs subjects to the correct, live survey.
	3. Ensure that respondents can specify the end-of-survey random confirmation code provided to subjects who complete the Qualtrics survey.

### Launching the HIT

Once the MTurk HIT has been created, it can be used to recruit and pay subjects.

#### Piloting
The HIT should first be launched as a pilot study, including no fewer than 20 subjects recruited from MTurk, to ensure proper functionality in both MTurk and Qualtrics prior to distribution using a full sample.

* Navigate back to the "Create" tab at the navigation bar at the top of the MTurk Requester page.
* Select "Publish Batch" to the left of the relevant "Project."
* On the "Preview" page, confirm the following:
	* Confirm the accuracy of the Reward, HITs available, Duration, and Qualifications listed at the top of the page.
	* Confirm the format of the "HIT Preview," and the accuracy of the Anonymous Link and survey code text box.
* On the "Confirm and Publish" page, confirm the following:
	* Confirm the accuracy of the Batch Properties.
	* Confirm the accuracy of the HITs specifics.
	* Confirm the accuracy of the Cost Summary.
	* Confirm the accuracy and sufficiency of Payment.
		* Confirm the accuracy of the Payment Method.
		* Where appropriate, if using funds from an external source (e.g., from a faculty research account), confirm the status of the HIT and Qualtrics survey prior to the transfer of relevant funds.
			* Funds should match the quoted Balance Due exactly.
	* Once all aspects of the HIT are confirmed, select "Purchase & Publish"; the HIT's progress may now be monitored by navigating to the "Manage" tab at the navigation bar at the top of the MTurk Requester page.
* Confirm the validity of the pilot study using Qualtrics and MTurk data (the latter of which can be accessed via Manage &rarr; Results) and potential MTurker feedback, and correct any remaining errors.

#### Full distribution
Once the pilot study has been completed and accuracy of all design elements and data are confirmed, the study may be distributed to the entire subject pool.

* Given a flawless pilot study, launch the HIT following the relevant instructions in [Piloting](#piloting), on *n* - *k* subjects, where *n* refers to the total number of subjects targeted for the study, and *k* refers to the number of subjects included in the pilot.
	* Subjects from the pilot stage should be excluded using a new qualification type (which can be assigned in [`MTurkR`](https://github.com/cloudyr/MTurkR/wiki)).
	* It is recommended that the full distribution of the survey still be rolled out in tranches of no more than 20 respondents each, and that the researcher monitor responses. `MTurkR` provides a functionality to automate sequential bulk HIT assignments of fewer than 10 participants each (this is `MTurkR`'s recommendation, as assigning HITs in batches of fewer than 10 allows the researcher to circumvent MTurk's 20% surcharge on bulk HIT assignments). The code excludes workers who completed the previous HITs. `MTurkR` provides [code and instructions](https://github.com/cloudyr/MTurkR/wiki/Circumventing-Batch-Pricing).

* If problems arise while piloting, the researcher should correct all apparent errors; depending on the severity, the researcher may choose to proceed according to one of the following approaches:

	* Re-pilot the study, using a separate pilot group.
	* Proceed according to Points 1 - 3 in [Full Distribution](#full-distribution).
	* Proceed by relaunching the HIT with *n* subjects.

		* The relaunched HIT should exclude the *k* subjects from the flawed pilot study.

## *When Things Go Wrong*

Sometimes, even with extensive alpha- and beta-testing, surveys do not behave in the same way when distributed on MTurk as they do during testing. Piloting surveys and rolling out surveys in tranches, as discussed above (see [Piloting](#piloting) and [Full Distribution](#full-distribution)), should limit damage.

Carefully monitor responses as they come in. If there is a problem with survey flow, cancel the MTurk HIT so that no new workers can accept it. Leave the Qualtrics survey open until all MTurk workers completing the assignment can complete the survey and receive an end-of-survey confirmation code. Once all workers have completed the survey, pause response collection in Qualtrics.

Regardless of whether responses are usable as data, MTurk workers who completed the survey should be paid according to the HIT advertisement.

In general, if MTurk workers are unable to complete the survey or HIT due to survey flow problems or other errors that are no fault of their own, the researcher has a responsibility to ensure that all workers who attempted to complete the HIT are paid. If workers were not able to complete the HIT due to such problems and they contact the researcher directly, `MTurkR` has [instructions](https://github.com/cloudyr/MTurkR/wiki/Paying-Workers-for-Unsubmitted-HITs) for paying workers for un-submitted HITs.

<!--
Additions planned for upcoming versions:
* Best practices for working with MTurkers
    - treating MTurkers well (Turkopticon)
    - HITs worth Turking for
    - working as a Turker before publishing a HIT
-->
