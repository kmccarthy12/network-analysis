library(readxl)
library(tidygraph)
library(ggraph)

student_nodes <- read_excel("lab-1/data/student-attributes.xlsx") #nodes
student_edges <- read_excel("lab-1/data/student-edgelist.xlsx") #edges

#create a "network object" or "table graph" in tidygraph lingo

student_network <- tbl_graph(edges = student_edges,
                             nodes = student_nodes,
                             directed = TRUE) # tells  model the edges are directional (e.g., it matters that 1 -> 7, but 7 does not go to 1)

student_network

#making simple sociograms

plot(student_network) #baseR

autograph(student_network) #uses a stress layout

autograph(student_network,
          node_label = id,
          node_colour = gender) 

#making better sociograms

#layouts and edges for different shapes
ggraph(student_network, layout = "fr") + 
  geom_node_point() + #adds nodes to gg
  geom_edge_fan()  #adds links (edges) between nodes

#extra special graph
ggraph(student_network, layout = "fr") + 
  geom_edge_link(arrow = arrow(length = unit(1, 'mm')), 
                 end_cap = circle(3, 'mm'),
                 start_cap = circle(3, 'mm'),
                 alpha = .1) +
  geom_node_point(aes(size = local_size(),
                      color = gender)) +
  geom_node_text(aes(label = id),
                 repel=TRUE) +
  theme_graph()
