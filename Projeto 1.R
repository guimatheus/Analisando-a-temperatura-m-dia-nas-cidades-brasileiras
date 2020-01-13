# Analisando a Temperatura Média nas Cidades Brasileiras


# Dataset: Berkeley Earth
# Link: http://berkeleyearth.org/data

# Façs o download do arquivo zip no link abaixo e descompacte na mesma pasta onde está este script. 
# https://drive.google.com/open?id=1nSwP3Y0V7gncbnG_DccNhrTRxmUNqMqa

# Instalando e carregando pacotes necessários para este projeto
install.packages("readr")
install.packages("data.table")
install.packages("dplyr")
install.packages("ggplot2")
library(readr)
library(dplyr)
library(ggplot2)
library(scales)
library(data.table)

# Carregando os dados através do csv Tempraturas Globais
df <- fread("TemperaturasGlobais.csv")
View(distinct(df,City))


# Visualizando os dados importados para o data frame
head(df)

# Criando subsets dos dados carregados
cidadesBrasil <- subset(df, Country == 'Brazil')
cidadesBrasil <- na.omit(cidadesBrasil)
head(cidadesBrasil)
nrow(df)
nrow(cidadesBrasil)


# Preparação e Organização

# Convertendo as Datas
cidadesBrasil$dt <- as.POSIXct(cidadesBrasil$dt,format='%Y-%m-%d')
cidadesBrasil$Month <- month(cidadesBrasil$dt)
cidadesBrasil$Year <- year(cidadesBrasil$dt)

# Carregando os subsets

# Palmas
palmas <- subset(cidadesBrasil, City == 'Palmas')
palmas <- subset(palmas, Year %in% c(1796,1846,1896,1946,1996,2012))

# Curitiba
curitiba <- subset(cidadesBrasil, City == 'Curitiba')
curitiba <- subset(curitiba, Year %in% c(1796,1846,1896,1946,1996,2012))

# Recife
recife <- subset(cidadesBrasil, City=='Recife')
recife <- subset(recife,Year %in% c(1796,1846,1896,1946,1996,2012))


# Construindo os Plots
p_palmas <- ggplot(palmas, aes(x = (Month), y = AverageTemperature, color = as.factor(Year))) +
  geom_smooth(se = FALSE,fill = NA, size = 2) +
  theme_light(base_size = 20) +
  xlab("Mês")+
  ylab("Temperatura Média") +
  scale_color_discrete("") +
  ggtitle("Temperatura Média ao longo dos anos em Palmas") +
  theme(plot.title = element_text(size = 18))

p_curitiba <- ggplot(curitiba, aes(x = (Month), y = AverageTemperature, color = as.factor(Year))) +
  geom_smooth(se = FALSE,fill = NA, size = 2) +
  theme_light(base_size = 20) +
  xlab("Mês")+
  ylab("Temperatura") +
  scale_color_discrete("") +
  ggtitle("Temperatura Média ao longo dos anos em Curitiba") +
  theme(plot.title = element_text(size = 18))

p_recife <- ggplot(recife, aes(x = (Month), y = AverageTemperature, color = as.factor(Year))) +
  geom_smooth(se = FALSE,fill = NA, size = 2) +
  theme_light(base_size = 20) +
  xlab("Mês")+
  ylab("Temperatura Média") +
  scale_color_discrete("") +
  ggtitle("Temperatura Média ao longo dos anos em Recife") +
  theme(plot.title = element_text(size = 18))

# Plotando
p_palmas
p_curitiba
p_recife