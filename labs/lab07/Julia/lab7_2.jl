using Plots
using DifferentialEquations

N = 650
n0 = 7

function func(du, u, p, t)
	(n) = u
	du[1] = (0.00009 + 0.44 * u[1])*(N - u[1])
end

v0=[n0]
tspan=(0.0, 0.10)
problem = ODEProblem(func, v0, tspan)
solution = solve(problem, dtmax=0.05)

n = [u[1] for u in solution.u]
T = [t for t in solution.t]


max_n = 0;
max_n_t = 0;
max_n_n = 0;
for (i, t) in enumerate(T)
    if solution(t, Val{1})[1] > max_n
        global max_n = solution(t, Val{1})[1]
        global max_n_t = t
        global max_n_n = n[i]
    end
end


plt = plot(dpi=700, title="Эффективность рекламы. Случай 2.",bg=:lightgrey, legend=true)
plot!(plt, T, n, color=:magenta, label="Объём проинформированных о товаре/услуге")
plot!(plt, [max_n_t], [max_n_n], seriestype = :scatter, color=:blue, label = "Момент времени скорость распространения рекламы будет 
иметь максимальное значение" )

savefig(plt, "lab7_2.png")