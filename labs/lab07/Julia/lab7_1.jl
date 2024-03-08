using Plots
using DifferentialEquations

N = 650
n0 = 7

function func(du, u, p, t)
	n = u
	du[1] = (0.44 + 0.0021 * u[1])*(N - u[1])
end

v0=[n0]
tspan=(0.0, 5.0)
problem = ODEProblem(func, v0, tspan)
solution = solve(problem, dtmax=0.05)

n = [u[1] for u in solution.u]
T = [t for t in solution.t]

plt = plot(dpi=700, title="Эффективность рекламы. Случай 1.",bg=:lightgrey, legend=:bottomright)
plot!(plt, T, n, color=:deeppink, label="Объём проинформированных о товаре/услуге")

savefig(plt, "lab7_1.png")