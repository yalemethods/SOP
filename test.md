	        }
    
	    # If the number of assignments in the batch has not yet been reached, wait
	    # 30 seconds before repeating the loop and checking assignments again.
	    } else {
	      Sys.sleep(30)
	    }
	}
	```
        
	    The researcher may now examine the data from all HIT assignments (i.e., all assignments in all batches) as a `data.frame` object in `R`:

	```r
	assigns_list <- do.call("rbind", all_assigns)
	``` 

	    Note that the augmented code allows the researcher to examine output following each iteration of the repeat loop by specifying `"more"` upon receiving the relevant text prompt. To wit, the code could also be altered with minor modifications to require researcher approval for the creation of *each* subsequent. 

* Given the unlikely possibility of a problematic pilot study, the researcher must correct all apparent errors; depending on the severity, the researcher may choose to proceed according to one of the following approaches:
	
	* Re-pilot the study, using a separate pilot group.
	* Proceed according to Points 1 - 3 in [Full Distribution](#full-distribution).
	* Proceed by relaunching the HIT with *n* subjects.
		
		* The relaunched HIT should exclude the *k* subjects from the flawed pilot study.

## *When Things Go Wrong* 

Sometimes, even with extensive alpha- and beta-testing, surveys do not behave in the same way when distributed on MTurk as they do during testing. Piloting surveys and rolling out surveys in tranches, as discussed above (see [Piloting](#piloting) and [Full Distribution](#full-distribution)), should limit damage. 

Carefully monitor responses as they come in. If there is a problem with survey flow, cancel the MTurk HIT so that no new workers can accept it. Leave the Qualtrics survey open until all MTurk workers completing the assignment can complete the survey and receive an end-of-survey confirmation code. Once all workers have completed the survey, pause response collection in Qualtrics. 

Regardless of whether responses are usable as data, MTurk workers who completed the survey should be paid according to the HIT advertisement. 

In general, if MTurk workers are unable to complete the survey or HIT due to survey flow problems or other errors that are no fault of their own, the researcher has a responsibility to ensure that all workers who attempted to complete the HIT are paid. If workers were not able to complete the HIT due to such problems and they contact the researcher directly, `MTurkR` has [instructions](https://github.com/cloudyr/MTurkR/wiki/Paying-Workers-for-Unsubmitted-HITs) for paying workers for un-submitted HITs.

## *Data Analaysis*

### Answer-Choice Codings

#### Confirm codings

Prior to further analysis, the correctness answer-choice codings represented in the collected data should be confirmed. It is recommended that the researcher examine *each* variable to ensure that it contains the correct numeric answer-choice codings, as established in the Qualtrics survey.

* It is of critical importance that the researcher perform this step diligently when comparing across surveys, or performing replication studies.

#### Clean variables
<!--
Include text regarding coding/recoding, making indicators, coalescing, imputation.
-->
Despite careful design in both Qualtrics and MTurk, the researcher may find that additional data-cleaning is a necessity. Whenever possible, it is recommended that the researcher perform this cleaning within Qualtrics (see [Randomization](#randomization) for information on recoding variables following data collection). However, the researcher may also wish to recode variables "by hand," in `R`; or, to clean variables by imputing missing values.

* When variables must be recoded in R, it is recommended that the researcher use [[decide whether we want the researcher to use `dplyr::recode` here; my view is that we should recommend all base-`R` implementations]]

* For the purposes of imputation, it is recommended that the researcher follow the Standard Operating Procedures for the Green Lab at Columbia University (@lin2015standard), with one minor refinement (mode imputation):
	* In cases in which more than 20% of responses are missing, the researcher should create an indicator variable denoting missingness in the given variable.
	* In all other cases, mean or mode imputation should be employed; it is recommended that the researcher use mean imputation for all ordinal or binary variables, whereas mode imputation is recommended for categorical/nominal variables.
	The below `impute()` function will assess missingness in variables, and will perform imputation automatically, where appropriate (note that `impute()` performs mean imputation by default; the function will perform mode imputation if the researcher sets the `ord` argument to `FALSE`):
	
	```r
    impute <- function(x, ord = TRUE) {
      if (ord) {
        if (sum(is.na(x)) <= 20) {
          x[is.na(x)] <- mean(x, na.rm = TRUE)
        } else {
          x[is.na(x)] <- -99
        }
      } else {
        if (sum(is.na(x)) <= 20) {
          x[is.na(x)] <- num_mode(x)
        } else {
          x[is.na(x)] <- -99
        }
      }
      return(x)
    }
    ```

#### Recoding variables

The researcher may, in some cases, need to recode variables in `R`. In the case of recoding a single value in a variable, the researcher may replace the value as demonstrated in the example below:

```r
variable <- c(1, 2, 3, 4, 99)

variable[variable == 99] <- NA
```

In cases in which the researcher must recode multiple values within a single variable at once, it is recommended that the researcher utilize a canned `recode()` command. Examples exist in both the `car` and the `dplyr` packages (each of which can be installed with `install.packages()`); the choice of canned command may be informed by syntax and data input/output. 

The `car::recode()` command is recommended due to its mildly greater flexibility with inputs (see description of `dplyr::recode()` below for further explanation). The command takes as its first argument a numeric or character vector, or a factor; and as its second argument, a character string of recode specifications. The function can be used as in the example below (note that the function is called as `car::recode()` so as to avoid conflict with `dplyr`):

```r
variable <- c(1, 2, 1, 1, 3, 4, 2, 5, 4, 2)

recoded_variable <- car::recode(variable, "1 = 5; 2 = 4; 4 = 2; 5 = 1")
```

Researchers may instead prefer to use the `dplyr::recode()` command; `dplyr::recode()` also takes as its main argument a vector; unlike `car::recode()`, however, `dplyr::recode()` will not take as its argument a factor. Instead, the researcher must instead use `recode_factor()` in order to recode a factor within `dplyr`.

#### Randomized Variables

When working with randomized versions of a question (e.g., two questions that randomize answer-choice order), it may be useful to create indicators of which version a subject received, as well as to aggregate the collected responses into a single variable.

* The researcher may wish to create indicator variables to represent which version of a randomized question a given subject received. This operation is simple to perform using `ifelse()` in `R`; if missing values are coded as `NA` (which is recommended), the researcher may use the following code:

	```r
	version_1 <- c(1, NA, 2, NA, 3, NA, 4, NA, 5, NA)	version_2 <- c(NA, 1, NA, 2, NA, 3, NA, 4, NA, 5)
	
	received_version_1 <- ifelse(is.na(version_1), 0, 1)
	received_version_2 <- ifelse(is.na(version_2), 0, 1)
	```
	
	If missingness is coded differently, e.g., as `-99`, the researcher may instead employ the below code:
	
	```r
	version_1 <- c(1, -99, 2, -99, 3, -99, 4, -99, 5, -99)
	version_2 <- c(-99, 1, -99, 2, -99, 3, -99, 4, -99, 5)
	
	received_version_1 <- ifelse(version_1 == -99, 0, 1)
	received_version_2 <- ifelse(version_2 == -99, 0, 1)
	```

* The researcher may wish to aggregate all answer selections into a single variable. This operation requires a `coalesce()` function; reproduced below is an [efficient function](stackoverflow.com/questions/19253820/how-to-implement-coalesce-efficiently-in-r) to perform this operation:

    ```r
    coalesce <- function(...) {
      Reduce(function(x, y) {
        i <- which(is.na(x))
        x[i] <- y[i]
        x},
        list(...))
    }
    ```

	The `coalesce()` function can then be used thusly, e.g., to aggregate three versions of a treatment:
	
	```r
	version_1 <- c(NA, 1, NA, 2, NA, 3, NA, 4, NA, 5)
	version_2 <- c(1, NA, NA, NA, 2, NA, NA, NA, 3, NA)
	version_3 <- c(NA, NA, 1, NA, NA, NA, 2, NA, NA, NA)
	
	treatment <- coalesce(version_1, version_2, version_3)
	```

# References

# Appendix

## *MTurk HIT default format HTML code*
Below is the recommended default format for an MTurk HIT for survey research; note that the format is adapted from an MTurk template:

```html
<!-- For help on using this template, see the blog post: http://mechanicalturk.typepad.com/blog/2014/04/
editing-the-survey-link-project-template-in-the-ui.html --><!-- Bootstrap v3.0.3 -->
<!DOCTYPE html>

<html>
<head>
	<link href="https://s3.amazonaws.com/mturk-public/bs30/css/bootstrap.min.css" rel="stylesheet">

	<title>
	</title>
</head>

<body>
	<section class="container" id="SurveyLink" style=
	"margin-bottom:15px; padding: 10px 10px; font-family: Verdana, Geneva, sans-serif; 
	color:#333333; font-size:0.9em;">
		<div class="row col-xs-12 col-md-12">
			<!-- Instructions -->


			<div class="panel panel-primary">
				<div class="panel-heading">
					<strong>Instructions</strong>
				</div>


				<div class="panel-body">
					<p style="font-family:"><span style="font-size: 14.6667px;"><b>Welcome!&nbsp;Thank you very
					much for your participation in this survey.&nbsp;</b></span><b style=
					"font-size: 14.6667px;">We&#39;re trying to understand &lt;purpose of study
					here&gt;.</b><span style="font-size: 14.6667px;"><b>&nbsp;The survey should take approximately
					&lt;duration here&gt; minutes to complete. Please answer all questions to the best of your
					ability. If you complete this survey, you may be recontacted for a follow-up
					survey.</b></span>
					</p>


					<p style="font-family:">&nbsp;</p>


					<p style="font-family:"><span style="font-weight: 700;"><span style=
					"font-size: 11pt;">Purpose:</span></span>
					</p>


					<p style="font-family:"><span style="font-size: 11pt;">We are conducting a research study on
					&lt;purpose of study here&gt;.</span>
					</p>


					<p style="font-family:"><span style="font-size: 11pt;">&nbsp;</span>
					</p>


					<p style="font-family:"><span style="font-weight: 700;"><span style=
					"font-size: 11pt;">Procedures:</span></span>
					</p>


					<p style="font-family:"><span style="font-size: 11pt;">Participation in this study will
					involve completing a short survey of approximately &lt;duration here&gt;&nbsp;minutes and you
					will receive $&lt;rate here&gt;&nbsp;for your completion of the survey.</span>
					</p>


					<p style="font-family:"><span style="font-size: 11pt;">&nbsp;</span>
					</p>


					<p style="font-family:"><span style="font-weight: 700;"><span style="font-size: 11pt;">Risks
					and Benefits:</span></span>
					</p>


					<p style="font-family:"><span style="font-size: 11pt;">It is unlikely, but possible, that
					participants in this study may experience distress over the nature of the questions. Although
					this study may not benefit you personally, we hope that our results will add to the knowledge
					about &lt;purpose of study here&gt;, and you may leave better informed after the conclusion of
					the study.</span>
					</p>


					<p style="font-family:"><span style="font-size: 11pt;">&nbsp;</span>
					</p>


					<p style="font-family:"><span style="font-weight: 700;"><span style=
					"font-size: 11pt;">Confidentiality</span></span><span style="font-size: 11pt;"></span>
					</p>


					<p style="font-family:"><span style="font-size: 11pt;">All of your responses will be
					anonymous. When we publish any results from this study we will do so in a way that does not
					identify you. We may also share the data with other researchers so that they can check the
					accuracy of our conclusions but will only do so if we are confident that your anonymity is
					protected.</span>
					</p>


					<p style="font-family:"><span style="font-size: 11pt;">&nbsp;</span>
					</p>


					<p style="font-family:"><span style="font-weight: 700;"><span style=
					"font-size: 11pt;">Voluntary Participation:</span></span><span style=
					"font-size: 11pt;"></span>
					</p>


					<p style="font-family:"><span style="font-size: 11pt;">Participation in this study is
					completely voluntary. You are free to decline to participate, to end participation at any time
					for any reason, or to refuse to answer any individual question without penalty.</span>
					</p>


					<p style="font-family:"><span style="font-size: 11pt;">&nbsp;</span>
					</p>


					<p style="font-family:"><span style="font-weight: 700;"><span style=
					"font-size: 11pt;">Questions:</span></span><span style="font-size: 11pt;"></span>
					</p>


					<p style="font-family:"><span style="font-size: 11pt;">If you have any questions about this
					study, you may contact the investigators, &lt;primary pesearcher(s) name(s) here&gt;, at
					&lt;primary researcher(s) email address(es) here&gt;.</span>
					</p>


					<p style="font-family:"><span style="font-size: 11pt;">&nbsp;</span>
					</p>


					<p style="font-family:"><span style="font-size: 11pt;">If you would like to talk with someone
					other than the researchers to discuss problems or concerns, to discuss situations in the event
					that a member of the research team is not available, or to discuss your rights as a research
					participant, you may contact the &lt;relevant IRB information (including name, address, and
					phone number) here&gt;,&nbsp;</span><span style=
					"font-size: 11pt;">relevant IRB email here</span><span style="font-size: 11pt;">. Additional
					information is available at&nbsp;</span><span style="font-size: 11pt;">relevant IRB website
					URL here</span><span style="font-size: 11pt;">.</span>
					</p>
				</div>
			</div>
			<!-- End Instruction -->


			<table>
				<tbody>
					<tr>
						<td><strong>Anonymous survey link:</strong>
						</td>

						<td><span style="color:#0000FF;">Anonymous Link here</span>
						</td>
					</tr>


					<tr>
						<td><strong>Qualtrics end-of-survey completion code here:</strong>
						</td>

						<td style="vertical-align: middle;"><input class="form-control" id="surveycode" name=
						"surveycode" placeholder="e.g. 123456" type="text">
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</section>
	<!-- close container section -->
	<style type="text/css">
	   td {
	      font-size:1.0em;
	      padding:5px 5px;
	   }
	</style>
</body>
</html>
```


<!--
Additions planned for upcoming versions:
* Include `MTurkR` code to:
    - automatically pay respondents
    - publish the HIT in tranches (automatically)
    - recontact on an individual basis (i.e., assigning one HIT per subject)
* Best practices for working with MTurkers
    - treating MTurkers well (Turkopticon)
    - HITs worth Turking for
    - working as a Turker before publishing a HIT
* Best practices for when things go wrong
    - close down the survey?
    - stop running ads?
    - in any/all case(s), be sure to still pay people
-->
