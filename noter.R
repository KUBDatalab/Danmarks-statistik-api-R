data %>% 
  ggplot(aes(TID, INDHOLD, color = CIVILSTAND)) +
  geom_line() +
  facet_wrap(~OMRÅDE)
