# install most recent version of exam package
# install.packages("exams", repos="http://R-Forge.R-project.org")

library(exams)

# check whether latex is present and specify path to latexmk
Sys.which("latexmk")
latex_executable <- Sys.which("pdflatex")
options(texi2dvi = latex_executable)



all_files <- list.files('rmd/', full.names = TRUE)



# every variant should go into separate folder
# for the moment n > 1 does overwrite old questions in texdir folder
# scrambling is done by sample()




make_variants = function(files, n_variants = 1, 
                         add_seed = 777,
                         pdf_dir_prefix = "pdf", tex_dir_prefix = "tex", 
                         name = "the_exam", 
                         language = "ru",
                         date = "2018-10-26", institution = "Higher School of Economics",
                         logo = "",
                         encoding = "UTF-8",
                         samepage = TRUE, 
                         reglength = 3, # is not working?
                         blank = 0,
                         header = "\\input{../header.tex}",
                         title = "Probability theory and Statistics") {
  
  all_solutions = list()
  
  for (variant_no in 1:n_variants) {
    set.seed(variant_no + add_seed)
    files_shuffled = sample(files)
    
    pdf_folder = paste0(pdf_dir_prefix, "_", variant_no)
    tex_folder = paste0(tex_dir_prefix, "_", variant_no)
      
    dir.create(pdf_folder, showWarnings = FALSE)
    dir.create(tex_folder, showWarnings = FALSE)
    
        
    exams <- exams2nops(files_shuffled, n = 1, 
                        dir = pdf_folder, 
                        verbose = TRUE, 
                        language = language,
                        texdir = tex_folder, 
                        name = name,
                        date = date, institution = institution,
                        logo = logo,
                        encoding = encoding,
                        samepage = samepage, 
                        reglength = reglength, # is not working?
                        blank = blank,
                        header = header,
                        title = title)
    cat("Variant ", variant_no, " done.")
    all_solutions[[variant_no]] = exams_metainfo(exams)
  }
  return(all_solutions)
}



make_variants2 = function(files, n_variants = 1, 
                         add_seed = 777,
                         pdf_dir_prefix = "pdf", tex_dir_prefix = "tex", 
                         name = "the_exam", 
                         language = "ru",
                         date = "2018-10-26", institution = "Higher School of Economics",
                         logo = "",
                         encoding = "UTF-8",
                         samepage = TRUE, 
                         reglength = 3, # is not working?
                         blank = 0,
                         template = "mod_template.tex",
                         title = "Probability theory and Statistics") {
  
  all_solutions = list()
  
  for (variant_no in 1:n_variants) {
    set.seed(variant_no + add_seed)
    files_shuffled = sample(files)
    
    pdf_folder = paste0(pdf_dir_prefix, "_", variant_no)
    tex_folder = paste0(tex_dir_prefix, "_", variant_no)
    
    dir.create(pdf_folder, showWarnings = FALSE)
    dir.create(tex_folder, showWarnings = FALSE)
    
    
    exams <- exams2pdf(files_shuffled, n = 1, 
                        dir = pdf_folder, 
                        verbose = TRUE, 
                        language = language,
                        texdir = tex_folder, 
                        name = name,
                        date = date, institution = institution,
                        logo = logo,
                        encoding = encoding,
                        samepage = samepage, 
                        reglength = reglength, # is not working?
                        blank = blank,
                        template = template,
                        title = title)
    cat("Variant ", variant_no, " done.")
    all_solutions[[variant_no]] = exams_metainfo(exams)
  }
  return(all_solutions)
}



notall_files = head(all_files, 10)


sol = make_variants2(notall_files, n_variants = 4)

print(sol[[1]], 1)



