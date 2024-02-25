using Plots; gr()
using DifferentialEquations;

# Случай 2: x'' + 10*x' + x = 0

function lorenz!(du, u, p, t)
	a, b = p;
	du[1] = u[2];
	du[2] = -a*du[1] -b*u[1]
end

# Задаем начальные условия
const x = 0;
const y = 2;
u0 = [x, y]

p = (sqrt(10), 1)
tspan = (0.0, 55.0)

# Задаем задачу 
problem = ODEProblem(lorenz!, u0, tspan, p)

# Решение данной задачи

solution = solve(problem, dtmax = 0.05)

# Создаю холст 1
plot(solution)

# Сохраняю результат в файл
savefig("lab04_2_julia.png")

# Создаю холст 2
plot(solution, vars=(2,1))

# Сохраняю результат в файл
savefig("lab04_2_pp_julia.png")
