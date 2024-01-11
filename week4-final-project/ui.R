library(shiny)
library(bslib)
library(leaflet)

choices = c("aequorea_forskalea", "aglaura_hemistoma", "aglauropsis_kawari", 
            "amphinema_dinema", "amphinema_rugosum", "blackfordia_virginica", 
            "bougainvillia_macloviana", "bougainvillia_pagesi", "clytia_gracilis", 
            "clytia_hemisphaerica", "clytia_lomae", "clytia_simplex", "corymorpha_gracilis", 
            "corymorpha_januarii", "coryne_eximia", "cosmetirella_davisi", 
            "cunina_octonaria", "eucheilota_ventricularis", "euphysa_aurata", 
            "eutonina_scintillans", "gossea_brachymera", "halopsis_ocellata", 
            "hybocodon_chilensis", "hybocodon_unicus", "hydractinia_borealis", 
            "krampella_sp", "laodicea_pulchra", "laodicea_undulata", "leuckartiara_octona", 
            "liriope_tetraphylla", "lovenella_cirrata", "mitrocomella_brownei", 
            "mitrocomella_frigida", "modeeria_rotunda", "obelia_sp", "olindias_sambaquiensis", 
            "pegantha_laevis", "phialella_falklandica", "podocoryna_tenuis", 
            "proboscidactyla_mutabilis", "rathkea_formosissima", "rhopalonema_velatum", 
            "sminthea_eurygaster", "solmundella_bitentaculata", "turritopsis_nutricola", 
            "velella_velella")

card1 <- card("Species Distribution", leafletOutput(outputId = "plot"))
card2 <- card("Summary", tableOutput(outputId = "summary"))
card3 <- card("Histogram", plotOutput(outputId = "plot_histogram"))

page_sidebar(
        
        title = "Jellyfish Distribution",
        fillable = TRUE,
        fillable_mobile = TRUE,
        theme = bs_theme(bootswatch = "cerulean"),

        sidebar = sidebar(
          selectInput("species", "chose species", choices = choices),
          open = TRUE
          ),

        layout_column_wrap(
          width = 1/2,
          height = 300,
          card1,
          layout_column_wrap(
            width = 1,
            heights_equal = "row",
            card2, card3
          )
        )
  )

