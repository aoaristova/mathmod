using Plots
using DifferentialEquations

N = 650
n0 = 7

function func(du, u, p, t)
	n = u
	du[1] = (0.77*t + 0.5 * cos(t)* u[1])*(N - u[1])
end

v0=[n0]
tspan=(0.0, 0.10)
problem = ODEProblem(func, v0, tspan)
solution = solve(problem, dtmax=0.05)

n = [u[1] for u in solution.u]
T = [t for t in solution.t]

plt = plot(dpi=700, title="Эффективность рекламы. Случай 3.",bg=:lightgrey, legend=true)
plot!(plt, T, n, color=:purple, label="Объём проинформированных о товаре/услуге")

savefig(plt, "lab7_3.png")