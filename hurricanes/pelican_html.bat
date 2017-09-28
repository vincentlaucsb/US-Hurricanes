Rscript -e "rmarkdown::render('hurricane_intro.Rmd', output_format='html_document')"
Rscript -e "rmarkdown::render('hurricane_severity.Rmd', output_format='html_document')"
Rscript -e "rmarkdown::render('hurricane_us.Rmd', output_format='html_document')"

python pelican_convert.py