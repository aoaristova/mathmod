using Plots; gr()
using DifferentialEquations;

# Случай 1: x'' + 15*x = 0

function lorenz!(du, u, p, t)
	a = p;
	du[1] = u[2];
	du[2] = -a*u[1]
end

# Задаем начальные условия
const x = 0;
const y = 2;
u0 = [x, y]

p = 15
tspan = [0, 55]

# Задаем задачу 
problem = ODEProblem(lorenz!, u0, tspan, p)

# Решение данной задачи

solution = solve(problem, dtmax = 0.05)

# Создаю холст 1
plot(solution)

# Сохраняю результат в файл
savefig("lab04_1_julia.png")

# Создаю холст 2
plot(solution, vars=(2,1))

# Сохраняю результат в файл
savefig("lab04_1_pp_julia.png")
