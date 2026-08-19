* Load dataset
clear all
use "V:\Projecten\Depar\Data\20230301_Data\PsAID12\2-Schone Data\PsAID12-complete.dta", clear
global columns_gp gp01 gp02 gp03 gp04 gp05 gp06 gp07 gp08 gp09 gp10 gp11 gp12
keep respondentid mm $columns_gp psaid12

**# Select variable
gen Aflag = 1 // gp01
gen Bflag = 1 // gp02
gen Cflag = 1 // gp03
gen Dflag = 1 // gp04
gen Eflag = 1 // gp05
gen Fflag = 1 // gp06
gen Gflag = 1 // gp07
gen Hflag = 1 // gp08
gen Iflag = 1 // gp09
gen Jflag = 1 // gp10
gen Kflag = 1 // gp11
gen Lflag = 1 // gp12


**# Leave Pain Out
count if Aflag ==  1
if r(N) > 0 {
	global columns_gp gp02 gp03 gp04 gp05 gp06 gp07 gp08 gp09 gp10 gp11 gp12  // No Pain
	
	display "Leave Pain Out iteration "
	
		preserve

			summarize respondentid mm
			  
			// Run GSEM Model
			capture noisily gsem ($columns_gp <- ), lclass(C 6) startvalues(randomid, draws(5)) // Run Mixture Model
			if _rc != 0 {
				display as error "Iteration 'noGP01' did not converge. Skipping..."
				
				* Swipe dataset
				gen clusters = .
				gen algorithm = "gsemGaussK6"
				gen NO = "noGP01"
				gen convergence = "Failed Convergence"
				keep respondentid mm clusters algorithm NO convergence
				rename clusters noGP01_clusters
				
				* Save dataset as failed before continueing
				cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\GSEM Clustering\Leave-One-Out_K6"
				save gsemGaussK6_noGP01_FAILED.dta, replace
				restore
				continue
			}
			summarize respondentid mm
			
			// Compute posterior probabilities
			predict pr_*, classposterior 		// Compute Probabilities
				
			// Assign Clusters
			gen clusters = .
			replace clusters = 1 if pr_1 > pr_2 & pr_1 > pr_3 & pr_1 > pr_4 & pr_1 > pr_5 & pr_1 > pr_6 
			replace clusters = 2 if pr_2 > pr_1 & pr_2 > pr_3 & pr_2 > pr_4 & pr_2 > pr_5 & pr_2 > pr_6 
			replace clusters = 3 if pr_3 > pr_1 & pr_3 > pr_2 & pr_3 > pr_5 & pr_3 > pr_5 & pr_3 > pr_6 
			replace clusters = 4 if pr_4 > pr_1 & pr_4 > pr_2 & pr_4 > pr_3 & pr_4 > pr_5 & pr_4 > pr_6 
			replace clusters = 5 if pr_5 > pr_1 & pr_5 > pr_2 & pr_5 > pr_3 & pr_5 > pr_4 & pr_5 > pr_6 
			replace clusters = 6 if pr_6 > pr_1 & pr_6 > pr_2 & pr_6 > pr_3 & pr_6 > pr_4 & pr_6 > pr_5
				
			// Rename vars
			rename pr_# noGP01_pr# 
			rename clusters noGP01_clusters
		
			* Tag dataset with bootstrap iteration & algorithm
			gen algorithm = "gsemGaussK6"
			gen NO = "noGP01"

			* Save dataset for this iteration
			cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Leave-One-Out_K6"
			sort respondentid mm
			save gsemGaussK6_noGP01.dta, replace 
		
		restore
}

**# Leave Fatigue Out
count if Bflag ==  1
if r(N) > 0 {
	global columns_gp gp01 gp03 gp04 gp05 gp06 gp07 gp08 gp09 gp10 gp11 gp12  // No Fatigue
	
	display "Leave Fatigue Out iteration "
	
		preserve

			summarize respondentid mm
			  
			// Run GSEM Model
			capture noisily gsem ($columns_gp <- ), lclass(C 6) startvalues(randomid, draws(5)) // Run Mixture Model
			if _rc != 0 {
				display as error "Iteration 'noGP02' did not converge. Skipping..."
				
				* Swipe dataset
				gen clusters = .
				gen algorithm = "gsemGaussK6"
				gen NO = "noGP02"
				gen convergence = "Failed Convergence"
				keep respondentid mm clusters algorithm NO convergence
				rename clusters noGP02_clusters
				
				* Save dataset as failed before continueing
				cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\GSEM Clustering\Leave-One-Out_K6"
				save gsemGaussK6_noGP02_FAILED.dta, replace
				restore
				continue
			}
			summarize respondentid mm
			
			// Compute posterior probabilities
			predict pr_*, classposterior 		// Compute Probabilities
				
			// Assign Clusters
			gen clusters = .
			replace clusters = 1 if pr_1 > pr_2 & pr_1 > pr_3 & pr_1 > pr_4 & pr_1 > pr_5 & pr_1 > pr_6 
			replace clusters = 2 if pr_2 > pr_1 & pr_2 > pr_3 & pr_2 > pr_4 & pr_2 > pr_5 & pr_2 > pr_6 
			replace clusters = 3 if pr_3 > pr_1 & pr_3 > pr_2 & pr_3 > pr_5 & pr_3 > pr_5 & pr_3 > pr_6 
			replace clusters = 4 if pr_4 > pr_1 & pr_4 > pr_2 & pr_4 > pr_3 & pr_4 > pr_5 & pr_4 > pr_6 
			replace clusters = 5 if pr_5 > pr_1 & pr_5 > pr_2 & pr_5 > pr_3 & pr_5 > pr_4 & pr_5 > pr_6 
			replace clusters = 6 if pr_6 > pr_1 & pr_6 > pr_2 & pr_6 > pr_3 & pr_6 > pr_4 & pr_6 > pr_5
				
			// Rename vars
			rename pr_# noGP02_pr# 
			rename clusters noGP02_clusters
		
			* Tag dataset with bootstrap iteration & algorithm
			gen algorithm = "gsemGaussK6"
			gen NO = "noGP02"

			* Save dataset for this iteration
			cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Leave-One-Out_K6"
			sort respondentid mm
			save gsemGaussK6_noGP02.dta, replace 
		
		restore
}

**# Leave Skin Out
count if Cflag ==  1
if r(N) > 0 {
	global columns_gp gp01 gp02 gp04 gp05 gp06 gp07 gp08 gp09 gp10 gp11 gp12  // No skin
	
	display "Leave Skin Out iteration "
	
		preserve

			summarize respondentid mm
			  
			// Run GSEM Model
			capture noisily gsem ($columns_gp <- ), lclass(C 6) startvalues(randomid, draws(5)) // Run Mixture Model
			if _rc != 0 {
				display as error "Iteration 'noGP03' did not converge. Skipping..."
				
				* Swipe dataset
				gen clusters = .
				gen algorithm = "gsemGaussK6"
				gen NO = "noGP03"
				gen convergence = "Failed Convergence"
				keep respondentid mm clusters algorithm NO convergence
				rename clusters noGP03_clusters
				
				* Save dataset as failed before continueing
				cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\GSEM Clustering\Leave-One-Out_K6"
				save gsemGaussK6_noGP03_FAILED.dta, replace
				restore
				continue
			}
			summarize respondentid mm
			
			// Compute posterior probabilities
			predict pr_*, classposterior 		// Compute Probabilities
				
			// Assign Clusters
			gen clusters = .
			replace clusters = 1 if pr_1 > pr_2 & pr_1 > pr_3 & pr_1 > pr_4 & pr_1 > pr_5 & pr_1 > pr_6 
			replace clusters = 2 if pr_2 > pr_1 & pr_2 > pr_3 & pr_2 > pr_4 & pr_2 > pr_5 & pr_2 > pr_6 
			replace clusters = 3 if pr_3 > pr_1 & pr_3 > pr_2 & pr_3 > pr_5 & pr_3 > pr_5 & pr_3 > pr_6 
			replace clusters = 4 if pr_4 > pr_1 & pr_4 > pr_2 & pr_4 > pr_3 & pr_4 > pr_5 & pr_4 > pr_6 
			replace clusters = 5 if pr_5 > pr_1 & pr_5 > pr_2 & pr_5 > pr_3 & pr_5 > pr_4 & pr_5 > pr_6 
			replace clusters = 6 if pr_6 > pr_1 & pr_6 > pr_2 & pr_6 > pr_3 & pr_6 > pr_4 & pr_6 > pr_5
				
			// Rename vars
			rename pr_# noGP03_pr# 
			rename clusters noGP03_clusters
		
			* Tag dataset with bootstrap iteration & algorithm
			gen algorithm = "gsemGaussK6"
			gen NO = "noGP03"

			* Save dataset for this iteration
			cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Leave-One-Out_K6"
			sort respondentid mm
			save gsemGaussK6_noGP03.dta, replace 
		
		restore
}

**# Leave Work Out
count if Dflag ==  1
if r(N) > 0 {
	global columns_gp gp01 gp02 gp03 gp05 gp06 gp07 gp08 gp09 gp10 gp11 gp12  // No Work
	
	display "Leave Work Out iteration "
	
		preserve

			summarize respondentid mm
			  
			// Run GSEM Model
			capture noisily gsem ($columns_gp <- ), lclass(C 6) startvalues(randomid, draws(5)) // Run Mixture Model
			if _rc != 0 {
				display as error "Iteration 'noGP04' did not converge. Skipping..."
				
				* Swipe dataset
				gen clusters = .
				gen algorithm = "gsemGaussK6"
				gen NO = "noGP04"
				gen convergence = "Failed Convergence"
				keep respondentid mm clusters algorithm NO convergence
				rename clusters noGP04_clusters
				
				* Save dataset as failed before continueing
				cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\GSEM Clustering\Leave-One-Out_K6"
				save gsemGaussK6_noGP04_FAILED.dta, replace
				restore
				continue
			}
			summarize respondentid mm
			
			// Compute posterior probabilities
			predict pr_*, classposterior 		// Compute Probabilities
				
			// Assign Clusters
			gen clusters = .
			replace clusters = 1 if pr_1 > pr_2 & pr_1 > pr_3 & pr_1 > pr_4 & pr_1 > pr_5 & pr_1 > pr_6 
			replace clusters = 2 if pr_2 > pr_1 & pr_2 > pr_3 & pr_2 > pr_4 & pr_2 > pr_5 & pr_2 > pr_6 
			replace clusters = 3 if pr_3 > pr_1 & pr_3 > pr_2 & pr_3 > pr_5 & pr_3 > pr_5 & pr_3 > pr_6 
			replace clusters = 4 if pr_4 > pr_1 & pr_4 > pr_2 & pr_4 > pr_3 & pr_4 > pr_5 & pr_4 > pr_6 
			replace clusters = 5 if pr_5 > pr_1 & pr_5 > pr_2 & pr_5 > pr_3 & pr_5 > pr_4 & pr_5 > pr_6 
			replace clusters = 6 if pr_6 > pr_1 & pr_6 > pr_2 & pr_6 > pr_3 & pr_6 > pr_4 & pr_6 > pr_5
				
			// Rename vars
			rename pr_# noGP04_pr# 
			rename clusters noGP04_clusters
		
			* Tag dataset with bootstrap iteration & algorithm
			gen algorithm = "gsemGaussK6"
			gen NO = "noGP04"

			* Save dataset for this iteration
			cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Leave-One-Out_K6"
			sort respondentid mm
			save gsemGaussK6_noGP04.dta, replace 
		
		restore
}

**# Leave Function Out
count if Eflag ==  1
if r(N) > 0 {
	global columns_gp gp01 gp02 gp03 gp04 gp06 gp07 gp08 gp09 gp10 gp11 gp12  // No Function
	
	display "Leave Function Out iteration "
	
		preserve

			summarize respondentid mm
			  
			// Run GSEM Model
			capture noisily gsem ($columns_gp <- ), lclass(C 6) startvalues(randomid, draws(5)) // Run Mixture Model
			if _rc != 0 {
				display as error "Iteration 'noGP05' did not converge. Skipping..."
				
				* Swipe dataset
				gen clusters = .
				gen algorithm = "gsemGaussK6"
				gen NO = "noGP05"
				gen convergence = "Failed Convergence"
				keep respondentid mm clusters algorithm NO convergence
				rename clusters noGP05_clusters
				
				* Save dataset as failed before continueing
				cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\GSEM Clustering\Leave-One-Out_K6"
				save gsemGaussK6_noGP05_FAILED.dta, replace
				restore
				continue
			}
			summarize respondentid mm
			
			// Compute posterior probabilities
			predict pr_*, classposterior 		// Compute Probabilities
				
			// Assign Clusters
			gen clusters = .
			replace clusters = 1 if pr_1 > pr_2 & pr_1 > pr_3 & pr_1 > pr_4 & pr_1 > pr_5 & pr_1 > pr_6 
			replace clusters = 2 if pr_2 > pr_1 & pr_2 > pr_3 & pr_2 > pr_4 & pr_2 > pr_5 & pr_2 > pr_6 
			replace clusters = 3 if pr_3 > pr_1 & pr_3 > pr_2 & pr_3 > pr_5 & pr_3 > pr_5 & pr_3 > pr_6 
			replace clusters = 4 if pr_4 > pr_1 & pr_4 > pr_2 & pr_4 > pr_3 & pr_4 > pr_5 & pr_4 > pr_6 
			replace clusters = 5 if pr_5 > pr_1 & pr_5 > pr_2 & pr_5 > pr_3 & pr_5 > pr_4 & pr_5 > pr_6 
			replace clusters = 6 if pr_6 > pr_1 & pr_6 > pr_2 & pr_6 > pr_3 & pr_6 > pr_4 & pr_6 > pr_5
				
			// Rename vars
			rename pr_# noGP05_pr# 
			rename clusters noGP05_clusters
		
			* Tag dataset with bootstrap iteration & algorithm
			gen algorithm = "gsemGaussK6"
			gen NO = "noGP05"

			* Save dataset for this iteration
			cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Leave-One-Out_K6"
			sort respondentid mm
			save gsemGaussK6_noGP05.dta, replace 
		
		restore
}

**# Leave Discomfort Out
count if Fflag ==  1
if r(N) > 0 {
	global columns_gp gp01 gp02 gp03 gp04 gp05 gp07 gp08 gp09 gp10 gp11 gp12  // No Discomfort
	
	display "Leave Discomfort Out iteration "
	
		preserve

			summarize respondentid mm
			  
			// Run GSEM Model
			capture noisily gsem ($columns_gp <- ), lclass(C 6) startvalues(randomid, draws(5)) // Run Mixture Model
			if _rc != 0 {
				display as error "Iteration 'noGP06' did not converge. Skipping..."
				
				* Swipe dataset
				gen clusters = .
				gen algorithm = "gsemGaussK6"
				gen NO = "noGP06"
				gen convergence = "Failed Convergence"
				keep respondentid mm clusters algorithm NO convergence
				rename clusters noGP06_clusters
				
				* Save dataset as failed before continueing
				cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\GSEM Clustering\Leave-One-Out_K6"
				save gsemGaussK6_noGP06_FAILED.dta, replace
				restore
				continue
			}
			summarize respondentid mm
			
			// Compute posterior probabilities
			predict pr_*, classposterior 		// Compute Probabilities
				
			// Assign Clusters
			gen clusters = .
			replace clusters = 1 if pr_1 > pr_2 & pr_1 > pr_3 & pr_1 > pr_4 & pr_1 > pr_5 & pr_1 > pr_6 
			replace clusters = 2 if pr_2 > pr_1 & pr_2 > pr_3 & pr_2 > pr_4 & pr_2 > pr_5 & pr_2 > pr_6 
			replace clusters = 3 if pr_3 > pr_1 & pr_3 > pr_2 & pr_3 > pr_5 & pr_3 > pr_5 & pr_3 > pr_6 
			replace clusters = 4 if pr_4 > pr_1 & pr_4 > pr_2 & pr_4 > pr_3 & pr_4 > pr_5 & pr_4 > pr_6 
			replace clusters = 5 if pr_5 > pr_1 & pr_5 > pr_2 & pr_5 > pr_3 & pr_5 > pr_4 & pr_5 > pr_6 
			replace clusters = 6 if pr_6 > pr_1 & pr_6 > pr_2 & pr_6 > pr_3 & pr_6 > pr_4 & pr_6 > pr_5
				
			// Rename vars
			rename pr_# noGP06_pr# 
			rename clusters noGP06_clusters
		
			* Tag dataset with bootstrap iteration & algorithm
			gen algorithm = "gsemGaussK6"
			gen NO = "noGP06"

			* Save dataset for this iteration
			cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Leave-One-Out_K6"
			sort respondentid mm
			save gsemGaussK6_noGP06.dta, replace 
		
		restore
}

**# Leave sleep Out
count if Gflag ==  1
if r(N) > 0 {
	global columns_gp gp01 gp02 gp03 gp04 gp05 gp06 gp08 gp09 gp10 gp11 gp12  // No sleep
	
	display "Leave Sleep Out iteration "
	
		preserve

			summarize respondentid mm
			  
			// Run GSEM Model
			capture noisily gsem ($columns_gp <- ), lclass(C 6) startvalues(randomid, draws(5)) // Run Mixture Model
			if _rc != 0 {
				display as error "Iteration 'noGP07' did not converge. Skipping..."
				
				* Swipe dataset
				gen clusters = .
				gen algorithm = "gsemGaussK6"
				gen NO = "noGP07"
				gen convergence = "Failed Convergence"
				keep respondentid mm clusters algorithm NO convergence
				rename clusters noGP07_clusters
				
				* Save dataset as failed before continueing
				cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\GSEM Clustering\Leave-One-Out_K6"
				save gsemGaussK6_noGP07_FAILED.dta, replace
				restore
				continue
			}
			summarize respondentid mm
			
			// Compute posterior probabilities
			predict pr_*, classposterior 		// Compute Probabilities
				
			// Assign Clusters
			gen clusters = .
			replace clusters = 1 if pr_1 > pr_2 & pr_1 > pr_3 & pr_1 > pr_4 & pr_1 > pr_5 & pr_1 > pr_6 
			replace clusters = 2 if pr_2 > pr_1 & pr_2 > pr_3 & pr_2 > pr_4 & pr_2 > pr_5 & pr_2 > pr_6 
			replace clusters = 3 if pr_3 > pr_1 & pr_3 > pr_2 & pr_3 > pr_5 & pr_3 > pr_5 & pr_3 > pr_6 
			replace clusters = 4 if pr_4 > pr_1 & pr_4 > pr_2 & pr_4 > pr_3 & pr_4 > pr_5 & pr_4 > pr_6 
			replace clusters = 5 if pr_5 > pr_1 & pr_5 > pr_2 & pr_5 > pr_3 & pr_5 > pr_4 & pr_5 > pr_6 
			replace clusters = 6 if pr_6 > pr_1 & pr_6 > pr_2 & pr_6 > pr_3 & pr_6 > pr_4 & pr_6 > pr_5
				
			// Rename vars
			rename pr_# noGP07_pr# 
			rename clusters noGP07_clusters
		
			* Tag dataset with bootstrap iteration & algorithm
			gen algorithm = "gsemGaussK6"
			gen NO = "noGP07"

			* Save dataset for this iteration
			cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Leave-One-Out_K6"
			sort respondentid mm
			save gsemGaussK6_noGP07.dta, replace 
		
		restore
}

**# Leave Coping Out
count if Hflag ==  1
if r(N) > 0 {
	global columns_gp gp01 gp02 gp03 gp04 gp05 gp06 gp07 gp09 gp10 gp11 gp12  // No Coping
	
	display "Leave Coping Out iteration "
	
		preserve

			summarize respondentid mm
			  
			// Run GSEM Model
			capture noisily gsem ($columns_gp <- ), lclass(C 6) startvalues(randomid, draws(5)) // Run Mixture Model
			if _rc != 0 {
				display as error "Iteration 'noGP08' did not converge. Skipping..."
				
				* Swipe dataset
				gen clusters = .
				gen algorithm = "gsemGaussK6"
				gen NO = "noGP08"
				gen convergence = "Failed Convergence"
				keep respondentid mm clusters algorithm NO convergence
				rename clusters noGP08_clusters
				
				* Save dataset as failed before continueing
				cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\GSEM Clustering\Leave-One-Out_K6"
				save gsemGaussK6_noGP08_FAILED.dta, replace
				restore
				continue
			}
			summarize respondentid mm
			
			// Compute posterior probabilities
			predict pr_*, classposterior 		// Compute Probabilities
				
			// Assign Clusters
			gen clusters = .
			replace clusters = 1 if pr_1 > pr_2 & pr_1 > pr_3 & pr_1 > pr_4 & pr_1 > pr_5 & pr_1 > pr_6 
			replace clusters = 2 if pr_2 > pr_1 & pr_2 > pr_3 & pr_2 > pr_4 & pr_2 > pr_5 & pr_2 > pr_6 
			replace clusters = 3 if pr_3 > pr_1 & pr_3 > pr_2 & pr_3 > pr_5 & pr_3 > pr_5 & pr_3 > pr_6 
			replace clusters = 4 if pr_4 > pr_1 & pr_4 > pr_2 & pr_4 > pr_3 & pr_4 > pr_5 & pr_4 > pr_6 
			replace clusters = 5 if pr_5 > pr_1 & pr_5 > pr_2 & pr_5 > pr_3 & pr_5 > pr_4 & pr_5 > pr_6 
			replace clusters = 6 if pr_6 > pr_1 & pr_6 > pr_2 & pr_6 > pr_3 & pr_6 > pr_4 & pr_6 > pr_5
				
			// Rename vars
			rename pr_# noGP08_pr# 
			rename clusters noGP08_clusters
		
			* Tag dataset with bootstrap iteration & algorithm
			gen algorithm = "gsemGaussK6"
			gen NO = "noGP08"

			* Save dataset for this iteration
			cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Leave-One-Out_K6"
			sort respondentid mm
			save gsemGaussK6_noGP08.dta, replace 
		
		restore
}

**# Leave Anxiety Out
count if Iflag ==  1
if r(N) > 0 {
	global columns_gp gp01 gp02 gp03 gp04 gp05 gp06 gp07 gp08 gp10 gp11 gp12  // No Anxiety
	
	display "Leave Anxiety Out iteration "
	
		preserve

			summarize respondentid mm
			  
			// Run GSEM Model
			capture noisily gsem ($columns_gp <- ), lclass(C 6) startvalues(randomid, draws(5)) // Run Mixture Model
			if _rc != 0 {
				display as error "Iteration 'noGP09' did not converge. Skipping..."
				
				* Swipe dataset
				gen clusters = .
				gen algorithm = "gsemGaussK6"
				gen NO = "noGP09"
				gen convergence = "Failed Convergence"
				keep respondentid mm clusters algorithm NO convergence
				rename clusters noGP09_clusters
				
				* Save dataset as failed before continueing
				cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\GSEM Clustering\Leave-One-Out_K6"
				save gsemGaussK6_noGP09_FAILED.dta, replace
				restore
				continue
			}
			summarize respondentid mm
			
			// Compute posterior probabilities
			predict pr_*, classposterior 		// Compute Probabilities
				
			// Assign Clusters
			gen clusters = .
			replace clusters = 1 if pr_1 > pr_2 & pr_1 > pr_3 & pr_1 > pr_4 & pr_1 > pr_5 & pr_1 > pr_6 
			replace clusters = 2 if pr_2 > pr_1 & pr_2 > pr_3 & pr_2 > pr_4 & pr_2 > pr_5 & pr_2 > pr_6 
			replace clusters = 3 if pr_3 > pr_1 & pr_3 > pr_2 & pr_3 > pr_5 & pr_3 > pr_5 & pr_3 > pr_6 
			replace clusters = 4 if pr_4 > pr_1 & pr_4 > pr_2 & pr_4 > pr_3 & pr_4 > pr_5 & pr_4 > pr_6 
			replace clusters = 5 if pr_5 > pr_1 & pr_5 > pr_2 & pr_5 > pr_3 & pr_5 > pr_4 & pr_5 > pr_6 
			replace clusters = 6 if pr_6 > pr_1 & pr_6 > pr_2 & pr_6 > pr_3 & pr_6 > pr_4 & pr_6 > pr_5
				
			// Rename vars
			rename pr_# noGP09_pr# 
			rename clusters noGP09_clusters
		
			* Tag dataset with bootstrap iteration & algorithm
			gen algorithm = "gsemGaussK6"
			gen NO = "noGP09"

			* Save dataset for this iteration
			cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Leave-One-Out_K6"
			sort respondentid mm
			save gsemGaussK6_noGP09.dta, replace 
		
		restore
}


**# Leave Shame Out
count if Jflag ==  1
if r(N) > 0 {
	global columns_gp gp01 gp02 gp03 gp04 gp05 gp06 gp07 gp08 gp09 gp11 gp12  // No Shame
	
	display "Leave Shame Out iteration "
	
		preserve

			summarize respondentid mm
			  
			// Run GSEM Model
			capture noisily gsem ($columns_gp <- ), lclass(C 6) startvalues(randomid, draws(5)) // Run Mixture Model
			if _rc != 0 {
				display as error "Iteration 'noGP10' did not converge. Skipping..."
				
				* Swipe dataset
				gen clusters = .
				gen algorithm = "gsemGaussK6"
				gen NO = "noGP10"
				gen convergence = "Failed Convergence"
				keep respondentid mm clusters algorithm NO convergence
				rename clusters noGP10_clusters
				
				* Save dataset as failed before continueing
				cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\GSEM Clustering\Leave-One-Out_K6"
				save gsemGaussK6_noGP10_FAILED.dta, replace
				restore
				continue
			}
			summarize respondentid mm
			
			// Compute posterior probabilities
			predict pr_*, classposterior 		// Compute Probabilities
				
			// Assign Clusters
			gen clusters = .
			replace clusters = 1 if pr_1 > pr_2 & pr_1 > pr_3 & pr_1 > pr_4 & pr_1 > pr_5 & pr_1 > pr_6 
			replace clusters = 2 if pr_2 > pr_1 & pr_2 > pr_3 & pr_2 > pr_4 & pr_2 > pr_5 & pr_2 > pr_6 
			replace clusters = 3 if pr_3 > pr_1 & pr_3 > pr_2 & pr_3 > pr_5 & pr_3 > pr_5 & pr_3 > pr_6 
			replace clusters = 4 if pr_4 > pr_1 & pr_4 > pr_2 & pr_4 > pr_3 & pr_4 > pr_5 & pr_4 > pr_6 
			replace clusters = 5 if pr_5 > pr_1 & pr_5 > pr_2 & pr_5 > pr_3 & pr_5 > pr_4 & pr_5 > pr_6 
			replace clusters = 6 if pr_6 > pr_1 & pr_6 > pr_2 & pr_6 > pr_3 & pr_6 > pr_4 & pr_6 > pr_5
				
			// Rename vars
			rename pr_# noGP10_pr# 
			rename clusters noGP10_clusters
		
			* Tag dataset with bootstrap iteration & algorithm
			gen algorithm = "gsemGaussK6"
			gen NO = "noGP10"

			* Save dataset for this iteration
			cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Leave-One-Out_K6"
			sort respondentid mm
			save gsemGaussK6_noGP10.dta, replace 
		
		restore
}

**# Leave Social Out
count if Kflag ==  1
if r(N) > 0 {
	global columns_gp gp01 gp02 gp03 gp04 gp05 gp06 gp07 gp08 gp09 gp10 gp12  // No Social
	
	display "Leave Social Out iteration "
	
		preserve

			summarize respondentid mm
			  
			// Run GSEM Model
			capture noisily gsem ($columns_gp <- ), lclass(C 6) startvalues(randomid, draws(5)) // Run Mixture Model
			if _rc != 0 {
				display as error "Iteration 'noGP11' did not converge. Skipping..."
				
				* Swipe dataset
				gen clusters = .
				gen algorithm = "gsemGaussK6"
				gen NO = "noGP11"
				gen convergence = "Failed Convergence"
				keep respondentid mm clusters algorithm NO convergence
				rename clusters noGP11_clusters
				
				* Save dataset as failed before continueing
				cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\GSEM Clustering\Leave-One-Out_K6"
				save gsemGaussK6_noGP11_FAILED.dta, replace
				restore
				continue
			}
			summarize respondentid mm
			
			// Compute posterior probabilities
			predict pr_*, classposterior 		// Compute Probabilities
				
			// Assign Clusters
			gen clusters = .
			replace clusters = 1 if pr_1 > pr_2 & pr_1 > pr_3 & pr_1 > pr_4 & pr_1 > pr_5 & pr_1 > pr_6 
			replace clusters = 2 if pr_2 > pr_1 & pr_2 > pr_3 & pr_2 > pr_4 & pr_2 > pr_5 & pr_2 > pr_6 
			replace clusters = 3 if pr_3 > pr_1 & pr_3 > pr_2 & pr_3 > pr_5 & pr_3 > pr_5 & pr_3 > pr_6 
			replace clusters = 4 if pr_4 > pr_1 & pr_4 > pr_2 & pr_4 > pr_3 & pr_4 > pr_5 & pr_4 > pr_6 
			replace clusters = 5 if pr_5 > pr_1 & pr_5 > pr_2 & pr_5 > pr_3 & pr_5 > pr_4 & pr_5 > pr_6 
			replace clusters = 6 if pr_6 > pr_1 & pr_6 > pr_2 & pr_6 > pr_3 & pr_6 > pr_4 & pr_6 > pr_5
				
			// Rename vars
			rename pr_# noGP11_pr# 
			rename clusters noGP11_clusters
		
			* Tag dataset with bootstrap iteration & algorithm
			gen algorithm = "gsemGaussK6"
			gen NO = "noGP11"

			* Save dataset for this iteration
			cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Leave-One-Out_K6"
			sort respondentid mm
			save gsemGaussK6_noGP11.dta, replace 
		
		restore
}

**# Leave Depression Out
count if Lflag ==  1
if r(N) > 0 {
	global columns_gp gp01 gp02 gp03 gp04 gp05 gp06 gp07 gp08 gp09 gp10 gp11  // No Depression
	
	display "Leave Social Out iteration "
	
		preserve

			summarize respondentid mm
			  
			// Run GSEM Model
			capture noisily gsem ($columns_gp <- ), lclass(C 6) startvalues(randomid, draws(5)) // Run Mixture Model
			if _rc != 0 {
				display as error "Iteration 'noGP12' did not converge. Skipping..."
				
				* Swipe dataset
				gen clusters = .
				gen algorithm = "gsemGaussK6"
				gen NO = "noGP12"
				gen convergence = "Failed Convergence"
				keep respondentid mm clusters algorithm NO convergence
				rename clusters noGP12_clusters
				
				* Save dataset as failed before continueing
				cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\GSEM Clustering\Leave-One-Out_K6"
				save gsemGaussK6_noGP12_FAILED.dta, replace
				restore
				continue
			}
			summarize respondentid mm
			
			// Compute posterior probabilities
			predict pr_*, classposterior 		// Compute Probabilities
				
			// Assign Clusters
			gen clusters = .
			replace clusters = 1 if pr_1 > pr_2 & pr_1 > pr_3 & pr_1 > pr_4 & pr_1 > pr_5 & pr_1 > pr_6 
			replace clusters = 2 if pr_2 > pr_1 & pr_2 > pr_3 & pr_2 > pr_4 & pr_2 > pr_5 & pr_2 > pr_6 
			replace clusters = 3 if pr_3 > pr_1 & pr_3 > pr_2 & pr_3 > pr_5 & pr_3 > pr_5 & pr_3 > pr_6 
			replace clusters = 4 if pr_4 > pr_1 & pr_4 > pr_2 & pr_4 > pr_3 & pr_4 > pr_5 & pr_4 > pr_6 
			replace clusters = 5 if pr_5 > pr_1 & pr_5 > pr_2 & pr_5 > pr_3 & pr_5 > pr_4 & pr_5 > pr_6 
			replace clusters = 6 if pr_6 > pr_1 & pr_6 > pr_2 & pr_6 > pr_3 & pr_6 > pr_4 & pr_6 > pr_5
				
			// Rename vars
			rename pr_# noGP12_pr# 
			rename clusters noGP12_clusters
		
			* Tag dataset with bootstrap iteration & algorithm
			gen algorithm = "gsemGaussK6"
			gen NO = "noGP12"

			* Save dataset for this iteration
			cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Leave-One-Out_K6"
			sort respondentid mm
			save gsemGaussK6_noGP12.dta, replace 
		
		restore
}

