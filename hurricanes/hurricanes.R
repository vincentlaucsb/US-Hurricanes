widen <- function(df) {
  # Given a data frame widen split it into two tables with the same length
  new_nrow = nrow(df)/2
  left = df[1:new_nrow, ]
  right = df[new_nrow: nrow(df), ]
  
  if (nrow(left) < nrow(right)) {
    left[new_nrow + 1, ] = rep("", ncol(left))
  }
  
  return(cbind(left, right))
}

SSHS_COLOR_SCALE <- c("#5ebaff", "#00faf4", "#ffffcc", "#ffe775",
                      "#ffc140", "#ff8f20", "#ff6060")
SSHS_LABELS <- c("Tropical Storm", "Tropical Depression", "Category 1",
                 "Category 2", "Category 3", "Category 4", "Category 5")

SSHS_COLOR_LABEL <- c()
for (i in 1:7) {
  SSHS_COLOR_LABEL[SSHS_LABELS[i]] = SSHS_COLOR_SCALE[i]
}

sshs_color <- function(category) {
  if (category == "Tropical Depression") {
    return("#5ebaff")
  } else if (category == "Tropical Storm") {
    return("#00faf4")
  } else if (category == "Category 1") {
    return("#ffffcc")
  } else if (category == "Category 2") {
    return("#ffe775")
  } else if (category == "Category 3") {
    return("#ffc140")
  } else if (category == "Category 4") {
    return("#ff8f20")
  } else {
    return("#ff6060")
  }
}

sshs_diagram <- function() {
  return(ggplot() +
    # Draw rectangles with text
    annotate("text", x=50, y=19, label="Tropical Depression") +
    annotate("rect", ymin=0, ymax=38, xmin=0, xmax=100, fill="#5ebaff", alpha=0.5) +
    
    annotate("text", x=50, y=55.5, label="Tropical Storm") +
    annotate("rect", ymin=38, ymax=73, xmin=0, xmax=100, fill="#00faf4", alpha=0.5) + 
    
    annotate("text", x=50, y=84.5, label="Category 1") +
    annotate("rect", ymin=74, ymax=95, xmin=0, xmax=100, fill="#ffffcc", alpha=0.5) +
    
    annotate("text", x=50, y=102.5, label="Category 2") +
    annotate("rect", ymin=95, ymax=110, xmin=0, xmax=100, fill="#ffe775", alpha=0.5) + 
      
    annotate("text", x=50, y=119.5, label="Category 3") +
    annotate("rect", ymin=110, ymax=129, xmin=0, xmax=100, fill="#ffc140", alpha=0.5) + 
      
    annotate("text", x=50, y=142.5, label="Category 4") +
    annotate("rect", ymin=129, ymax=156, xmin=0, xmax=100, fill="#ff8f20", alpha=0.5) + 
      
    annotate("text", x=50, y=178, label="Category 5") +
    annotate("rect", ymin=156, ymax=200, xmin=0, xmax=100, fill="#ff6060", alpha=0.5) +
    
    # Make x-axis disappear
    theme(axis.text.x = element_blank(),
          axis.ticks.x = element_blank(),
          axis.line.x = element_blank()) +
      
    labs(
      title="Saffir-Simpson Hurricane Wind Scale",
      x="",
      y="Miles Per Hour"
    ))
}