cars <- read_csv("auto-mpg.csv",col_names = TRUE)
cars

#Create Formula
formula <- mpg ~ horsepower + model_year

#Create Model Vector
model <- lm(formula, data = cars)

print(model)

#Create Grid
grid <- cars %>%
  data_grid(
    horsepower = seq_range(horsepower, by = 1),
    model_year = seq_range(model_year, by = 1)
  )

#Creating 3D Data Space
data_space <- ggplot(cars, aes(x = horsepower, y = model_year)) +
  geom_point(aes(color = mpg))

data_space

#Adding Predictions to Grid
predictions_mpg <- augment(model, newdata = grid)

#Tile the Plane
data_space +
  geom_tile(data = predictions_mpg, aes(fill = .fitted), alpha = 0.5)

#Drawing the 3D Scatterplot
plot_ly(data=cars, z=~mpg, x=~horsepower, y=~model_year, opacity = 0.5) %>%
  add_markers()

#Create the Objects for the Plane
x <- seq(max(cars$horsepower),min(cars$horsepower), by = -50)
y <- seq(min(cars$model_year),max(cars$model_year), by = 2)

plane <- outer(x,y, function(a,b){model$coef[1] + model$coef[2]*a + model$coef[3]*b})

#Draw the Plane
plot_ly(data=cars, z=~mpg, x=~horsepower, y=~model_year, opacity = 0.5) %>%
  add_markers() %>%
  add_surface(x = ~x, y = ~y, z=~plane, showscale = FALSE)