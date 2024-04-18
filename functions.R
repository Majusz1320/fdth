funkcja_liczenie <- function(fasta_plik){
  suma_g <- sum(fasta_plik == "g" )
  suma_c <- sum(fasta_plik == "c" )
  gcskew <- ((suma_c - suma_g)/(suma_c + suma_g))
}


funkcja_wykres <- function(gcskew){
  
  dlugosc <- (1:length(gcskew))
  dowykresu <- dplyr::bind_cols(gcskew, dlugosc)
  colnames(dowykresu) <- c("gcskew", "okno_odczytu")
  dowykresu |> dplyr::filter(!is.na(gcskew)) -> dowykresu
  ggplot2::ggplot(dowykresu, ggplot2::aes(okno_odczytu, gcskew))+
    ggplot2::geom_point(size = 1, colour = "lightblue")+
    ggplot2::geom_line(colour = "darkblue")+
    ggplot2::labs(title = "Wartośc GCskew, dla przesuwającej się ramki odczytu.", subtitle = "Oś Y przedstawia okna odczytu określone przez widnow_size i przesuwające się o window_by")+
    ggplot2::theme(legend.position = "right")
  
  
}

funkcja_rozdzielanie <- function(sekwencja_wklejana){
  sekwencja_podzielona <- strsplit(sekwencja_wklejana, "")
}