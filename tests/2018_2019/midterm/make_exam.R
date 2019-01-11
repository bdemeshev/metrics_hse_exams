# install most recent version of exam package
# install.packages("exams", repos="http://R-Forge.R-project.org")

library(exams)

# check whether latex is present and specify path to latexmk
Sys.which("latexmk")
latex_executable <- Sys.which("pdflatex")
options(texi2dvi = latex_executable)



files_all <- list.files('rmd/', pattern = "*.Rmd", full.names = TRUE)
files_all




# every variant should go into separate folder
# for the moment n > 1 does overwrite old questions in texdir folder
# scrambling is done by sample()


files_shuffled = files_all

# set.seed(777)
# files_shuffled <- sample(files_all)

files_sample = files_shuffled
files_sample



# exams <- exams2nops(files_sample, n = 1,
#                     dir = "pdf",
#                     verbose = TRUE,
#                     language = "ru",
#             texdir = "tex",
#             name = "the_exam",
#             date = "2018-09-18", institution = "Higher School of Economics",
#             logo = "",
#             encoding = "UTF-8",
#             samepage = TRUE,
#             reglength = 3, # is not working?
#             blank = 0,
#             header = "\\input{../header.tex}",
#             title = "Probability theory and Statistics")
# 
# sol <- exams_metainfo(exams)
# print(sol, 1)


exams2pdf_source = function(files_sample, n_vars = 1, add_seed = 777, 
                            pdf_dir = "pdf",
                            verbose = TRUE,
                            language = "ru",
                            tex_dir = "tex",
                            name = "the_exam",
                            date = "2018-09-18", institution = "Higher School of Economics",
                            logo = "",
                            encoding = "UTF-8",
                            samepage = TRUE,
                            reglength = 3, # is not working?
                            blank = 0,
                            header = "\\input{../header.tex}",
                            title = "Probability theory and Statistics") {
  for (var_no in 1:n_vars) {
    var_no_string = stringr::str_pad(var_no, 2, pad = "0")
    pdf_dir_no = paste0(pdf_dir, "_", var_no_string)
    dir.create(pdf_dir_no)
    tex_dir_no = paste0(tex_dir, "_", var_no_string)
    dir.create(pdf_dir_no)
    temp_dir_no = paste0("temp_", var_no_string)
    dir.create(temp_dir_no)
    supp_dir_no = paste0("supp_", var_no_string)
    dir.create(supp_dir_no)
    
    
    name_no = paste0(name, "_", var_no_string)

    set.seed(var_no + add_seed)
    files_sample = sample(files_sample)
    
    set.seed(var_no + add_seed)
    exams <- exams2pdf(file = files_sample, n = 1, template = "plain_no_sweave.tex", tdir = temp_dir_no, sdir = supp_dir_no,
                       dir = pdf_dir_no,
                       verbose = TRUE,
                       language = "ru",
                       texdir = tex_dir_no,
                       name = name_no,
                       date = date, institution = institution,
                       logo = logo,
                       encoding = encoding,
                       samepage = samepage,
                       reglength = 3, # is not working?
                       blank = blank,
                       header = header,
                       title = title)
    
  }
  return(TRUE)
}

exams2pdf_source(files_sample, n_vars = 4)

# 
# exams <- exams2pdf(files_sample, n = 1,
#                     dir = "pdf",
#                     verbose = TRUE,
#                     language = "ru",
#                     texdir = "tex",
#                     name = "the_exam",
#                     date = "2018-09-18", institution = "Higher School of Economics",
#                     logo = "",
#                     encoding = "UTF-8",
#                     samepage = TRUE,
#                     reglength = 3, # is not working?
#                     blank = 0,
#                     header = "\\input{../header.tex}",
#                     title = "Probability theory and Statistics")



