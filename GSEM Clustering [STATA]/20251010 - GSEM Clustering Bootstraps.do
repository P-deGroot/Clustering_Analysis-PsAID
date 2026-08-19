* Load dataset
clear all
use "V:\Projecten\Depar\Data\20230301_Data\PsAID12\2-Schone Data\PsAID12-complete.dta", clear
global columns_gp gp01 gp02 gp03 gp04 gp05 gp06 gp07 gp08 gp09 gp10 gp11 gp12
keep respondentid mm $columns_gp psaid12

**# SET IP ---------------------------------------------------------------------
set seed 12345
local reps = 1000  // Use Find and Replace to reset all 1000 to a another number of bootstraps

**# Select algorithm
gen Aflag = 0 // GaussK3
gen Bflag = 1 // GaussK4
gen Cflag = 0 // GaussK5
gen Dflag = 0 // GaussK6
gen Eflag = 0 // GaussK7

gen Fflag = 0 // PoissonK3
gen Gflag = 0 // PoissonK4
gen Hflag = 0 // PoissonK5
gen Iflag = 0 // PoissonK6
gen Jflag = 0 // PoissonK7

gen Kflag = 0 // WeibullK3
gen Lflag = 0 // WeibullK4
gen Mflag = 0 // WeibullK5
gen Nflag = 0 // WeibullK6
gen Oflag = 0 // WeibullK7

**# GAUSS ---------------------------------------------------------------------- 
// Gauss K = 3
count if Aflag ==  1
if r(N) > 0 {
	forvalues b = 1/`reps' {
		display "Bootstrap iteration `b' of `reps'"
		
		preserve

			// Draw Sample
			bsample    // resample dataset with replacement
			summarize respondentid mm
			  
			// Run GSEM Model
			capture noisily gsem ($columns_gp <- ), lclass(C 3) startvalues(randomid, draws(5)) // Run Mixture Model
			if _rc != 0 {
				display as error "Iteration `b' did not converge. Skipping..."
				* Swipe dataset
				gen clusters = .
				gen algorithm = "gsemGaussK3"
				gen bootstrap = `b'
				gen convergence = "Failed Convergence"
				keep respondentid mm clusters algorithm bootstrap convergence
				rename clusters b`b'_clusters
				
				* Save dataset as failed before continueing
				cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Gauss\gsemGaussK3_bootstrap1000"
				save gsemGaussK3_bootstrap`reps'_b`b'_FAILED.dta, replace
				restore
				continue
			}
					
			summarize respondentid mm
			
			// Compute posterior probabilities
			predict pr_*, classposterior 		// Compute Probabilities
				
			// Assign Clusters
			gen clusters = .
			replace clusters = 1 if pr_1 > pr_2 & pr_1 > pr_3
			replace clusters = 2 if pr_2 > pr_1 & pr_2 > pr_3
			replace clusters = 3 if pr_3 > pr_1 & pr_3 > pr_2
				
			// Rename vars
			rename pr_# b`b'_pr# 
			rename clusters b`b'_clusters
		
			* Tag dataset with bootstrap iteration & algorithm
			gen algorithm = "gsemGaussK3"
			gen bootstrap = `b'

			* Save dataset for this iteration
			cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Gauss\gsemGaussK3_bootstrap1000"
			sort respondentid mm
			save gsemGaussK3_bootstrap`reps'_b`b'.dta, replace 
		
		restore

	}
}
 
// Gauss K = 4
count if Bflag ==  1
if r(N) > 0 {
	forvalues b = 1/`reps' {
		display "Bootstrap iteration `b' of `reps'"
		
		preserve
			// Draw Sample
			bsample    // resample dataset with replacement
			summarize respondentid mm
			  
			// Run GSEM Model
			capture noisily gsem ($columns_gp <- ), lclass(C 4) startvalues(randomid, draws(5)) // Run Mixture Model
			if _rc != 0 {
				display as error "Iteration `b' did not converge. Skipping..."
				
				* Swipe dataset
				gen clusters = .
				gen algorithm = "gsemGaussK4"
				gen bootstrap = `b'
				gen convergence = "Failed Convergence"
				keep respondentid mm clusters algorithm bootstrap convergence
				rename clusters b`b'_clusters
				
				* Save dataset as failed before continueing
				cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Gauss\gsemGaussK4_bootstrap1000"
				save gsemGaussK4_bootstrap`reps'_b`b'_FAILED.dta, replace
				restore
				continue
			}
			summarize respondentid mm
			
			// Compute posterior probabilities
			predict pr_*, classposterior 		// Compute Probabilities
				
			// Assign Clusters
			gen clusters = .
			replace clusters = 1 if pr_1 > pr_2 & pr_1 > pr_3 & pr_1 > pr_4
			replace clusters = 2 if pr_2 > pr_1 & pr_2 > pr_3 & pr_2 > pr_4
			replace clusters = 3 if pr_3 > pr_1 & pr_3 > pr_2 & pr_3 > pr_4
			replace clusters = 4 if pr_4 > pr_1 & pr_4 > pr_2 & pr_4 > pr_3
				
			// Rename vars
			rename pr_# b`b'_pr# 
			rename clusters b`b'_clusters
		
			* Tag dataset with bootstrap iteration & algorithm
			gen algorithm = "gsemGaussK4"
			gen bootstrap = `b'

			* Save dataset for this iteration
			cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Gauss\gsemGaussK4_bootstrap1000"
			sort respondentid mm
			save gsemGaussK4_bootstrap`reps'_b`b'.dta, replace 
			
		restore
	}
}

// Gauss K = 5
count if Cflag ==  1
if r(N) > 0 {
	forvalues b = 1/`reps' {
		display "Bootstrap iteration `b' of `reps'"

		preserve

			// Draw Sample
			bsample    // resample dataset with replacement
			summarize respondentid mm
			  
			// Run GSEM Model
			capture noisily gsem ($columns_gp <- ), lclass(C 5) startvalues(randomid, draws(5)) // Run Mixture Model
			if _rc != 0 {
				display as error "Iteration `b' did not converge. Skipping..."
				
				* Swipe dataset
				gen clusters = .
				gen algorithm = "gsemGaussK5"
				gen bootstrap = `b'
				gen convergence = "Failed Convergence"
				keep respondentid mm clusters algorithm bootstrap convergence
				rename clusters b`b'_clusters
				
				* Save dataset as failed before continueing
				cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Gauss\gsemGaussK5_bootstrap1000"
				save gsemGaussK5_bootstrap`reps'_b`b'_FAILED.dta, replace
				restore
				continue
			}
			summarize respondentid mm
			
			// Compute posterior probabilities
			predict pr_*, classposterior 		// Compute Probabilities
				
			// Assign Clusters
			gen clusters = .
			replace clusters = 1 if pr_1 > pr_2 & pr_1 > pr_3 & pr_1 > pr_4 & pr_1 > pr_5 
			replace clusters = 2 if pr_2 > pr_1 & pr_2 > pr_3 & pr_2 > pr_4 & pr_2 > pr_5 
			replace clusters = 3 if pr_3 > pr_1 & pr_3 > pr_2 & pr_3 > pr_5 & pr_3 > pr_5 
			replace clusters = 4 if pr_4 > pr_1 & pr_4 > pr_2 & pr_4 > pr_3 & pr_4 > pr_5 
			replace clusters = 5 if pr_5 > pr_1 & pr_5 > pr_2 & pr_5 > pr_3 & pr_5 > pr_4
				
			// Rename vars
			rename pr_# b`b'_pr# 
			rename clusters b`b'_clusters
		
			* Tag dataset with bootstrap iteration & algorithm
			gen algorithm = "gsemGaussK5"
			gen bootstrap = `b'

			* Save dataset for this iteration
			cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Gauss\gsemGaussK5_bootstrap1000"
			sort respondentid mm
			save gsemGaussK5_bootstrap`reps'_b`b'.dta, replace 
		
		restore
	}
}

// Gauss K = 6
count if Dflag ==  1
if r(N) > 0 {
	forvalues b = 1/`reps' {
		display "Bootstrap iteration `b' of `reps'"

		preserve

			// Draw Sample
			bsample    // resample dataset with replacement
			summarize respondentid mm
			  
			// Run GSEM Model
			capture noisily gsem ($columns_gp <- ), lclass(C 6) startvalues(randomid, draws(5)) // Run Mixture Model
			if _rc != 0 {
				display as error "Iteration `b' did not converge. Skipping..."
				
				* Swipe dataset
				gen clusters = .
				gen algorithm = "gsemGaussK6"
				gen bootstrap = `b'
				gen convergence = "Failed Convergence"
				keep respondentid mm clusters algorithm bootstrap convergence
				rename clusters b`b'_clusters
				
				* Save dataset as failed before continueing
				cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Gauss\gsemGaussK6_bootstrap1000"
				save gsemGaussK6_bootstrap`reps'_b`b'_FAILED.dta, replace
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
			rename pr_# b`b'_pr# 
			rename clusters b`b'_clusters
		
			* Tag dataset with bootstrap iteration & algorithm
			gen algorithm = "gsemGaussK6"
			gen bootstrap = `b'

			* Save dataset for this iteration
			cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Gauss\gsemGaussK6_bootstrap1000"
			sort respondentid mm
			save gsemGaussK6_bootstrap`reps'_b`b'.dta, replace 
		
		restore
	
	}
}

// Gauss K = 7
count if Eflag ==  1
if r(N) > 0 {
	forvalues b = 1/`reps' {
		display "Bootstrap iteration `b' of `reps'"
		
		preserve

			// Draw Sample
			bsample    // resample dataset with replacement
			summarize respondentid mm
			  
			// Run GSEM Model
			capture noisily gsem ($columns_gp <- ), lclass(C 7) startvalues(randomid, draws(5)) // Run Mixture Model
			if _rc != 0 {
				display as error "Iteration `b' did not converge. Skipping..."
				
				* Swipe dataset
				gen clusters = .
				gen algorithm = "gsemGaussK7"
				gen bootstrap = `b'
				gen convergence = "Failed Convergence"
				keep respondentid mm clusters algorithm bootstrap convergence
				rename clusters b`b'_clusters
				
				* Save dataset as failed before continueing
				cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Gauss\gsemGaussK7_bootstrap1000"
				save gsemGaussK7_bootstrap`reps'_b`b'_FAILED.dta, replace
				restore
				continue
			}
			summarize respondentid mm
			
			// Compute posterior probabilities
			predict pr_*, classposterior 		// Compute Probabilities
				
			// Assign Clusters
			gen clusters = .
			replace clusters = 1 if pr_1 > pr_2 & pr_1 > pr_3 & pr_1 > pr_4 & pr_1 > pr_5 & pr_1 > pr_6 & pr_1 > pr_7 
			replace clusters = 2 if pr_2 > pr_1 & pr_2 > pr_3 & pr_2 > pr_4 & pr_2 > pr_5 & pr_2 > pr_6 & pr_2 > pr_7 
			replace clusters = 3 if pr_3 > pr_1 & pr_3 > pr_2 & pr_3 > pr_5 & pr_3 > pr_5 & pr_3 > pr_6 & pr_3 > pr_7 
			replace clusters = 4 if pr_4 > pr_1 & pr_4 > pr_2 & pr_4 > pr_3 & pr_4 > pr_5 & pr_4 > pr_6 & pr_4 > pr_7 
			replace clusters = 5 if pr_5 > pr_1 & pr_5 > pr_2 & pr_5 > pr_3 & pr_5 > pr_4 & pr_5 > pr_6 & pr_5 > pr_7 
			replace clusters = 6 if pr_6 > pr_1 & pr_6 > pr_2 & pr_6 > pr_3 & pr_6 > pr_4 & pr_6 > pr_5 & pr_6 > pr_7 
			replace clusters = 7 if pr_7 > pr_1 & pr_7 > pr_2 & pr_7 > pr_3 & pr_7 > pr_4 & pr_7 > pr_5 & pr_7 > pr_6
				 
			// Rename vars
			rename pr_# b`b'_pr# 
			rename clusters b`b'_clusters
		
			* Tag dataset with bootstrap iteration & algorithm
			gen algorithm = "gsemGaussK7"
			gen bootstrap = `b'

			* Save dataset for this iteration
			cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Gauss\gsemGaussK7_bootstrap1000"
			sort respondentid mm
			save gsemGaussK7_bootstrap`reps'_b`b'.dta, replace 
		
		restore
	}
}


**# POISSON--------------------------------------------------------------------- 
// Poisson K = 3
count if Fflag ==  1
if r(N) > 0 {
	forvalues b = 1/`reps' {
		display "Bootstrap iteration `b' of `reps'"
		
		preserve
			// Draw Sample
			bsample    // resample dataset with replacement
			summarize respondentid mm
			  
			// Run GSEM Model
			capture noisily gsem ($columns_gp <- ), poisson lclass(C 3) startvalues(randomid, draws(5)) // Run Mixture Model
			if _rc != 0 {
				display as error "Iteration `b' did not converge. Skipping..."
				
				* Swipe dataset
				gen clusters = .
				gen algorithm = "gsemPoissonK3"
				gen bootstrap = `b'
				gen convergence = "Failed Convergence"
				keep respondentid mm clusters algorithm bootstrap convergence
				rename clusters b`b'_clusters
				
				* Save dataset as failed before continueing
				cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Gauss\gsemPoissonK3_bootstrap1000"
				save gsemPoissonK3_bootstrap`reps'_b`b'_FAILED.dta, replace
				restore
				continue
			}
			summarize respondentid mm
			
			// Compute posterior probabilities
			predict pr_*, classposterior 		// Compute Probabilities
				
			// Assign Clusters
			gen clusters = .
			replace clusters = 1 if pr_1 > pr_2 & pr_1 > pr_3
			replace clusters = 2 if pr_2 > pr_1 & pr_2 > pr_3
			replace clusters = 3 if pr_3 > pr_1 & pr_3 > pr_2
				
			// Rename vars
			rename pr_# b`b'_pr# 
			rename clusters b`b'_clusters
		
			* Tag dataset with bootstrap iteration & algorithm
			gen algorithm = "gsemPoissonK3"
			gen bootstrap = `b'

			* Save dataset for this iteration
			cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Poisson\gsemPoissonK3_bootstrap1000"
			sort respondentid mm
			save gsemPoissonK3_bootstrap`reps'_b`b'.dta, replace 

		restore
	}
}
 
// Poisson K = 4
count if Gflag ==  1
if r(N) > 0 {
	forvalues b = 1/`reps' {
		display "Bootstrap iteration `b' of `reps'"

		preserve
			// Draw Sample
			bsample    // resample dataset with replacement
			summarize respondentid mm
			  
			// Run GSEM Model
			capture noisily gsem ($columns_gp <- ), poisson lclass(C 4) startvalues(randomid, draws(5)) // Run Mixture Model
			if _rc != 0 {
				display as error "Iteration `b' did not converge. Skipping..."
				
				* Swipe dataset
				gen clusters = .
				gen algorithm = "gsemPoissonK3"
				gen bootstrap = `b'
				gen convergence = "Failed Convergence"
				keep respondentid mm clusters algorithm bootstrap convergence
				rename clusters b`b'_clusters
				
				* Save dataset as failed before continueing
				cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Gauss\gsemPoissonK4_bootstrap1000"
				save gsemPoissonK4_bootstrap`reps'_b`b'_FAILED.dta, replace
				restore
				continue
			}
			summarize respondentid mm
			
			// Compute posterior probabilities
			predict pr_*, classposterior 		// Compute Probabilities
				
			// Assign Clusters
			gen clusters = .
			replace clusters = 1 if pr_1 > pr_2 & pr_1 > pr_3 & pr_1 > pr_4
			replace clusters = 2 if pr_2 > pr_1 & pr_2 > pr_3 & pr_2 > pr_4
			replace clusters = 3 if pr_3 > pr_1 & pr_3 > pr_2 & pr_3 > pr_4
			replace clusters = 4 if pr_4 > pr_1 & pr_4 > pr_2 & pr_4 > pr_3
				
			// Rename vars
			rename pr_# b`b'_pr# 
			rename clusters b`b'_clusters
		
			* Tag dataset with bootstrap iteration & algorithm
			gen algorithm = "gsemPoissonK4"
			gen bootstrap = `b'

			* Save dataset for this iteration
			cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Poisson\gsemPoissonK4_bootstrap1000"
			sort respondentid mm
			save gsemPoissonK4_bootstrap`reps'_b`b'.dta, replace 
			
		restore

	}
}

// Poisson K = 5
count if Hflag ==  1
if r(N) > 0 {
	forvalues b = 1/`reps' {
		display "Bootstrap iteration `b' of `reps'"
		
		preserve

			// Draw Sample
			bsample    // resample dataset with replacement
			summarize respondentid mm
			  
			// Run GSEM Model
			capture noisily gsem ($columns_gp <- ), poisson lclass(C 5) startvalues(randomid, draws(5)) // Run Mixture Model
			if _rc != 0 {
				display as error "Iteration `b' did not converge. Skipping..."
				
				* Swipe dataset
				gen clusters = .
				gen algorithm ="gsemPoissonK3"
				gen bootstrap = `b'
				gen convergence = "Failed Convergence"
				keep respondentid mm clusters algorithm bootstrap convergence
				rename clusters b`b'_clusters
				
				* Save dataset as failed before continueing
				cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Gauss\gsemPoissonK5_bootstrap1000"
				save gsemPoissonK5_bootstrap`reps'_b`b'_FAILED.dta, replace
				restore
				continue
			}
			summarize respondentid mm
			
			// Compute posterior probabilities
			predict pr_*, classposterior 		// Compute Probabilities
				
			// Assign Clusters
			gen clusters = .
			replace clusters = 1 if pr_1 > pr_2 & pr_1 > pr_3 & pr_1 > pr_4 & pr_1 > pr_5 
			replace clusters = 2 if pr_2 > pr_1 & pr_2 > pr_3 & pr_2 > pr_4 & pr_2 > pr_5 
			replace clusters = 3 if pr_3 > pr_1 & pr_3 > pr_2 & pr_3 > pr_5 & pr_3 > pr_5 
			replace clusters = 4 if pr_4 > pr_1 & pr_4 > pr_2 & pr_4 > pr_3 & pr_4 > pr_5 
			replace clusters = 5 if pr_5 > pr_1 & pr_5 > pr_2 & pr_5 > pr_3 & pr_5 > pr_4
				
			// Rename vars
			rename pr_# b`b'_pr# 
			rename clusters b`b'_clusters
		
			* Tag dataset with bootstrap iteration & algorithm
			gen algorithm = "gsemPoissonK5"
			gen bootstrap = `b'

			* Save dataset for this iteration
			cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Poisson\gsemPoissonK5_bootstrap1000"
			sort respondentid mm
			save gsemPoissonK5_bootstrap`reps'_b`b'.dta, replace 
		
		restore
	}
}

// Poisson K = 6
count if Iflag ==  1
if r(N) > 0 {
	forvalues b = 1/`reps' {
		display "Bootstrap iteration `b' of `reps'"
		
		preserve
			// Draw Sample
			bsample    // resample dataset with replacement
			summarize respondentid mm
			  
			// Run GSEM Model
			capture noisily gsem ($columns_gp <- ), poisson lclass(C 6) startvalues(randomid, draws(5)) // Run Mixture Model
			if _rc != 0 {
				display as error "Iteration `b' did not converge. Skipping..."
				
				* Swipe dataset
				gen clusters = .
				gen algorithm = "gsemPoissonK6"
				gen bootstrap = `b'
				gen convergence = "Failed Convergence"
				keep respondentid mm clusters algorithm bootstrap convergence
				rename clusters b`b'_clusters
				
				* Save dataset as failed before continueing
				cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Gauss\gsemPoissonK6_bootstrap1000"
				save gsemPoissonK6_bootstrap`reps'_b`b'_FAILED.dta, replace
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
			rename pr_# b`b'_pr# 
			rename clusters b`b'_clusters
		
			* Tag dataset with bootstrap iteration & algorithm
			gen algorithm = "gsemPoissonK6"
			gen bootstrap = `b'

			* Save dataset for this iteration
			// cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps"
			cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Poisson\gsemPoissonK6_bootstrap1000"
			sort respondentid mm
			// keep respondentid mm b`b'_pr*  b`b'_clusters bootstrap algorithm
			save gsemPoissonK6_bootstrap`reps'_b`b'.dta, replace 
		
		restore

	}
}

// Poisson K=7
count if Jflag ==  1
if r(N) > 0 {
	forvalues b = 1/`reps' {
		display "Bootstrap iteration `b' of `reps'"
		
		preserve
			// Draw Sample
			bsample    // resample dataset with replacement
			summarize respondentid mm
			  
			// Run GSEM Model
			capture noisily gsem ($columns_gp <- ), poisson lclass(C 7) startvalues(randomid, draws(5)) // Run Mixture Model
			if _rc != 0 {
				display as error "Iteration `b' did not converge. Skipping..."
				
				* Swipe dataset
				gen clusters = .
				gen algorithm = "gsemPoissonK7"
				gen bootstrap = `b'
				gen convergence = "Failed Convergence"
				keep respondentid mm clusters algorithm bootstrap convergence
				rename clusters b`b'_clusters
				
				* Save dataset as failed before continueing
				cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Gauss\gsemPoissonK7_bootstrap1000"
				save gsemPoissonK7_bootstrap`reps'_b`b'_FAILED.dta, replace
				restore
				continue
			}
			summarize respondentid mm
			
			// Compute posterior probabilities
			predict pr_*, classposterior 		// Compute Probabilities
				
			// Assign Clusters
			gen clusters = .
			replace clusters = 1 if pr_1 > pr_2 & pr_1 > pr_3 & pr_1 > pr_4 & pr_1 > pr_5 & pr_1 > pr_6 & pr_1 > pr_7 
			replace clusters = 2 if pr_2 > pr_1 & pr_2 > pr_3 & pr_2 > pr_4 & pr_2 > pr_5 & pr_2 > pr_6 & pr_2 > pr_7 
			replace clusters = 3 if pr_3 > pr_1 & pr_3 > pr_2 & pr_3 > pr_5 & pr_3 > pr_5 & pr_3 > pr_6 & pr_3 > pr_7 
			replace clusters = 4 if pr_4 > pr_1 & pr_4 > pr_2 & pr_4 > pr_3 & pr_4 > pr_5 & pr_4 > pr_6 & pr_4 > pr_7 
			replace clusters = 5 if pr_5 > pr_1 & pr_5 > pr_2 & pr_5 > pr_3 & pr_5 > pr_4 & pr_5 > pr_6 & pr_5 > pr_7 
			replace clusters = 6 if pr_6 > pr_1 & pr_6 > pr_2 & pr_6 > pr_3 & pr_6 > pr_4 & pr_6 > pr_5 & pr_6 > pr_7 
			replace clusters = 7 if pr_7 > pr_1 & pr_7 > pr_2 & pr_7 > pr_3 & pr_7 > pr_4 & pr_7 > pr_5 & pr_7 > pr_6
				 
			// Rename vars
			rename pr_# b`b'_pr# 
			rename clusters b`b'_clusters
		
			* Tag dataset with bootstrap iteration & algorithm
			gen algorithm = "gsemPoissonK7"
			gen bootstrap = `b'

			* Save dataset for this iteration
			// cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps"
			cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Poisson\gsemPoissonK7_bootstrap1000"
			sort respondentid mm
			// keep respondentid mm b`b'_pr*  b`b'_clusters bootstrap algorithm
			save gsemPoissonK7_bootstrap`reps'_b`b'.dta, replace 
		
		restore
	}
}


**#Weibull---------------------------------------------------------------------
* When using Weibull the response can not contain 0 values. Therefore add 1 to each reply of gp01. Since we are looking at correlations adding 1 to all gp01 answers won't change the outcome.
replace gp01 = gp01 + 1 // Answers now range from 1-11
replace gp02 = gp02 + 1 // Answers now range from 1-11
replace gp03 = gp03 + 1 // Answers now range from 1-11
replace gp04 = gp04 + 1 // Answers now range from 1-11
replace gp05 = gp05 + 1 // Answers now range from 1-11
replace gp06 = gp06 + 1 // Answers now range from 1-11
replace gp07 = gp07 + 1 // Answers now range from 1-11
replace gp08 = gp08 + 1 // Answers now range from 1-11
replace gp09 = gp09 + 1 // Answers now range from 1-11
replace gp10 = gp10 + 1 // Answers now range from 1-11
replace gp11 = gp11 + 1 // Answers now range from 1-11
replace gp12 = gp12 + 1 // Answers now range from 1-11

// Weibull K = 3
count if Kflag ==  1
if r(N) > 0 {
	forvalues b = 1/`reps' {
		display "Bootstrap iteration `b' of `reps'"
		
		preserve
			// Draw Sample
			bsample    // resample dataset with replacement
			summarize respondentid mm
			  
			// Run GSEM Model
			capture noisily gsem ($columns_gp <- ), weibull lclass(C 3) startvalues(randomid, draws(5)) // Run Mixture Model
			if _rc != 0 {
				display as error "Iteration `b' did not converge. Skipping..."
				
				* Swipe dataset
				gen clusters = .
				gen algorithm = "gsemWeibullK3"
				gen bootstrap = `b'
				gen convergence = "Failed Convergence"
				keep respondentid mm clusters algorithm bootstrap convergence
				rename clusters b`b'_clusters
				
				* Save dataset as failed before continueing
				cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Gauss\gsemWeibullK3_bootstrap1000"
				save gsemWeibullK3_bootstrap`reps'_b`b'_FAILED.dta, replace
				restore
				continue
			}
			summarize respondentid mm
			
			// Compute posterior probabilities
			predict pr_*, classposterior 		// Compute Probabilities
				
			// Assign Clusters
			gen clusters = .
			replace clusters = 1 if pr_1 > pr_2 & pr_1 > pr_3
			replace clusters = 2 if pr_2 > pr_1 & pr_2 > pr_3
			replace clusters = 3 if pr_3 > pr_1 & pr_3 > pr_2
				
			// Rename vars
			rename pr_# b`b'_pr# 
			rename clusters b`b'_clusters
		
			* Tag dataset with bootstrap iteration & algorithm
			gen algorithm = "gsemWeibullK3"
			gen bootstrap = `b'

			* Save dataset for this iteration
			cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Weibull\gsemWeibullK3_bootstrap1000"
			sort respondentid mm
			save gsemWeibullK3_bootstrap`reps'_b`b'.dta, replace 
		
		restore
	}
}
 
// Weibull K = 4
count if Lflag ==  1
if r(N) > 0 {
	forvalues b = 1/`reps' {
		display "Bootstrap iteration `b' of `reps'"

		preserve
			// Draw Sample
			bsample    // resample dataset with replacement
			summarize respondentid mm
			  
			// Run GSEM Model
			capture noisily gsem ($columns_gp <- ), weibull lclass(C 4) startvalues(randomid, draws(5)) // Run Mixture Model
			if _rc != 0 {
				display as error "Iteration `b' did not converge. Skipping..."
				
				* Swipe dataset
				gen clusters = .
				gen algorithm = "gsemWeibullK4"
				gen bootstrap = `b'
				gen convergence = "Failed Convergence"
				keep respondentid mm clusters algorithm bootstrap convergence
				rename clusters b`b'_clusters
				
				* Save dataset as failed before continueing
				cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Gauss\gsemWeibullK4_bootstrap1000"
				save gsemWeibullK4_bootstrap`reps'_b`b'_FAILED.dta, replace
				restore
				continue
			}
			summarize respondentid mm
			
			// Compute posterior probabilities
			predict pr_*, classposterior 		// Compute Probabilities
				
			// Assign Clusters
			gen clusters = .
			replace clusters = 1 if pr_1 > pr_2 & pr_1 > pr_3 & pr_1 > pr_4
			replace clusters = 2 if pr_2 > pr_1 & pr_2 > pr_3 & pr_2 > pr_4
			replace clusters = 3 if pr_3 > pr_1 & pr_3 > pr_2 & pr_3 > pr_4
			replace clusters = 4 if pr_4 > pr_1 & pr_4 > pr_2 & pr_4 > pr_3
				
			// Rename vars
			rename pr_# b`b'_pr# 
			rename clusters b`b'_clusters
		
			* Tag dataset with bootstrap iteration & algorithm
			gen algorithm = "gsemWeibullK4"
			gen bootstrap = `b'

			* Save dataset for this iteration
			cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Weibull\gsemWeibullK4_bootstrap1000"
			sort respondentid mm
			save gsemWeibullK4_bootstrap`reps'_b`b'.dta, replace 
			
		restore
			
	}
}

// Weibull K = 5
count if Mflag ==  1
if r(N) > 0 {
	forvalues b = 1/`reps' {
		display "Bootstrap iteration `b' of `reps'"
		
		preserve

			// Draw Sample
			bsample    // resample dataset with replacement
			summarize respondentid mm
			  
			// Run GSEM Model
			capture noisily gsem ($columns_gp <- ), weibull lclass(C 5) startvalues(randomid, draws(5)) // Run Mixture Model
			if _rc != 0 {
				display as error "Iteration `b' did not converge. Skipping..."
				
				* Swipe dataset
				gen clusters = .
				gen algorithm = "gsemWeibullK5"
				gen bootstrap = `b'
				gen convergence = "Failed Convergence"
				keep respondentid mm clusters algorithm bootstrap convergence
				rename clusters b`b'_clusters
				
				* Save dataset as failed before continueing
				cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Gauss\gsemWeibullK5_bootstrap1000"
				save gsemWeibullK5_bootstrap`reps'_b`b'_FAILED.dta, replace
				restore
				continue
			}
			summarize respondentid mm
			
			// Compute posterior probabilities
			predict pr_*, classposterior 		// Compute Probabilities
				
			// Assign Clusters
			gen clusters = .
			replace clusters = 1 if pr_1 > pr_2 & pr_1 > pr_3 & pr_1 > pr_4 & pr_1 > pr_5 
			replace clusters = 2 if pr_2 > pr_1 & pr_2 > pr_3 & pr_2 > pr_4 & pr_2 > pr_5 
			replace clusters = 3 if pr_3 > pr_1 & pr_3 > pr_2 & pr_3 > pr_5 & pr_3 > pr_5 
			replace clusters = 4 if pr_4 > pr_1 & pr_4 > pr_2 & pr_4 > pr_3 & pr_4 > pr_5 
			replace clusters = 5 if pr_5 > pr_1 & pr_5 > pr_2 & pr_5 > pr_3 & pr_5 > pr_4
				
			// Rename vars
			rename pr_# b`b'_pr# 
			rename clusters b`b'_clusters
		
			* Tag dataset with bootstrap iteration & algorithm
			gen algorithm = "gsemWeibullK5"
			gen bootstrap = `b'

			* Save dataset for this iteration
			// cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps"
			cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Weibull\gsemWeibullK5_bootstrap1000"
			sort respondentid mm
			// keep respondentid mm b`b'_pr*  b`b'_clusters bootstrap algorithm
			save gsemWeibullK5_bootstrap`reps'_b`b'.dta, replace 
		
		restore
	}
}

// Weibull K = 6
count if Nflag ==  1
if r(N) > 0 {
	forvalues b = 1/`reps' {
		display "Bootstrap iteration `b' of `reps'"
		
		preserve
			// Draw Sample
			bsample    // resample dataset with replacement
			summarize respondentid mm
			  
			// Run GSEM Model
			capture noisily gsem ($columns_gp <- ), weibull lclass(C 6) startvalues(randomid, draws(5)) // Run Mixture Model
			if _rc != 0 {
				display as error "Iteration `b' did not converge. Skipping..."
				
				* Swipe dataset
				gen clusters = .
				gen algorithm = "gsemWeibullK6"
				gen bootstrap = `b'
				gen convergence = "Failed Convergence"
				keep respondentid mm clusters algorithm bootstrap convergence
				rename clusters b`b'_clusters
				
				* Save dataset as failed before continueing
				cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Gauss\gsemWeibullK6_bootstrap1000"
				save gsemWeibullK6_bootstrap`reps'_b`b'_FAILED.dta, replace
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
			rename pr_# b`b'_pr# 
			rename clusters b`b'_clusters
		
			* Tag dataset with bootstrap iteration & algorithm
			gen algorithm = "gsemWeibullK6"
			gen bootstrap = `b'

			* Save dataset for this iteration
			// cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps"
			cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Weibull\gsemWeibullK6_bootstrap1000"
			sort respondentid mm
			// keep respondentid mm b`b'_pr*  b`b'_clusters bootstrap algorithm
			save gsemWeibullK6_bootstrap`reps'_b`b'.dta, replace 
		
		restore

	}
}

// Weibull K=7
count if Oflag ==  1
if r(N) > 0 {
	forvalues b = 1/`reps' {
		display "Bootstrap iteration `b' of `reps'"
		
		preserve
			// Draw Sample
			bsample    // resample dataset with replacement
			summarize respondentid mm
			  
			// Run GSEM Model
			capture noisily gsem ($columns_gp <- ), weibull lclass(C 7) startvalues(randomid, draws(5)) // Run Mixture Model
			if _rc != 0 {
				display as error "Iteration `b' did not converge. Skipping..."
				
				* Swipe dataset
				gen clusters = .
				gen algorithm = "gsemWeibullK7"
				gen bootstrap = `b'
				gen convergence = "Failed Convergence"
				keep respondentid mm clusters algorithm bootstrap convergence
				rename clusters b`b'_clusters
				
				* Save dataset as failed before continueing
				cd "V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Gauss\gsemWeibullK7_bootstrap1000"
				save gsemWeibullK7_bootstrap`reps'_b`b'_FAILED.dta, replace
				restore
				continue
			}
			summarize respondentid mm
			
			// Compute posterior probabilities
			predict pr_*, classposterior 		// Compute Probabilities
				
			// Assign Clusters
			gen clusters = .
			replace clusters = 1 if pr_1 > pr_2 & pr_1 > pr_3 & pr_1 > pr_4 & pr_1 > pr_5 & pr_1 > pr_6 & pr_1 > pr_7 
			replace clusters = 2 if pr_2 > pr_1 & pr_2 > pr_3 & pr_2 > pr_4 & pr_2 > pr_5 & pr_2 > pr_6 & pr_2 > pr_7 
			replace clusters = 3 if pr_3 > pr_1 & pr_3 > pr_2 & pr_3 > pr_5 & pr_3 > pr_5 & pr_3 > pr_6 & pr_3 > pr_7 
			replace clusters = 4 if pr_4 > pr_1 & pr_4 > pr_2 & pr_4 > pr_3 & pr_4 > pr_5 & pr_4 > pr_6 & pr_4 > pr_7 
			replace clusters = 5 if pr_5 > pr_1 & pr_5 > pr_2 & pr_5 > pr_3 & pr_5 > pr_4 & pr_5 > pr_6 & pr_5 > pr_7 
			replace clusters = 6 if pr_6 > pr_1 & pr_6 > pr_2 & pr_6 > pr_3 & pr_6 > pr_4 & pr_6 > pr_5 & pr_6 > pr_7 
			replace clusters = 7 if pr_7 > pr_1 & pr_7 > pr_2 & pr_7 > pr_3 & pr_7 > pr_4 & pr_7 > pr_5 & pr_7 > pr_6
				 
			// Rename vars
			rename pr_# b`b'_pr# 
			rename clusters b`b'_clusters
		
			* Tag dataset with bootstrap iteration & algorithm
			gen algorithm = "gsemWeibullK7"
			gen bootstrap = `b'

			* Save dataset for this iteration
			"V:\084438_deGroot\SNN\Analyse\GSEM Clustering\Bootstraps\Weibull\gsemWeibullK7_bootstrap1000"
			sort respondentid mm
			save gsemWeibullK7_bootstrap`reps'_b`b'.dta, replace 
		
		restore
	}
}