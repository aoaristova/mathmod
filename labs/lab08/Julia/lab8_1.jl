using Plots 
using DifferentialEquations

M10 = 2.1
M20 = 1.4
pcr = 16
N = 19
q = 1
t1 = 12
t2 = 15
p1 = 9
p2 = 7

a1 = pcr/(t1*t1 * p1*p1 * N * q)
a2 = pcr/(t2*t2 * p2*p2 * N * q)
b = pcr/(t1*t1 * p1*p1 * t2*t2 * p2*p2 * N * q)
c1 = (pcr - p1)/(t1*p1)
c2 = (pcr - p2)/(t2*p2)

function func(du, u, p, t)
	M1, M2 = u
	du[1] = u[1] - (b/c1)*u[1]*u[2] - (a1/c1)*u[1]*u[1]
	du[2] = (c2/c1)*u[2] - (b/c1)*u[1]*u[2] -(a2/c1)*u[2]*u[2]
end

v0 = [M10, M20]
tspan = (0.0, 55.0)
problem = ODEProblem(func, v0, tspan)
solution = solve(problem, dtmax = 0.05)
M1 = [u[1] for u in solution.u]
M2 = [u[2] for u in solution.u]
T = [t for t in solution.t]

plt = plot(dpi=700, legend=:best, bg=:black, title="Модель конкуренции двух фирм. Случай 1.")
plot!(plt, T, M1, label="Оборотные средства фирмы 1", color=:yellow)
plot!(plt, T, M2, label="Оборотные средства фирмы 2", color=:lightblue)

savefig(plt, "lab8_1.png")