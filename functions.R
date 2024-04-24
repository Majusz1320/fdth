geneplot_function <- function(wgrany_plik){
  wgrany_plik <- uploaded_file
  ggplot(wgrany_plik, aes(xmin = start, xmax = end, y = molecule, fill = gene)) +
    geom_gene_arrow() +
    facet_wrap(~ molecule, scales = "free", ncol = 1) +
    scale_fill_brewer(palette = "Set3")
}
