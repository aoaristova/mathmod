using Plots
using DifferentialEquations

N = 9000 	# проживающих на острове
I0 = 70 	# число заболевших, являющихся распространителями инфекции
R0 = 10 	# здоровых людей с иммунитетом к болезни
S0 = N - I0 - R0 	# число людей восприимчивых к болезни, но пока здоровых, в начальный момент времени

a = 0.01 	# коэффициент заболеваемости 
b = 0.02	# коэффициент выздоравения 

# I(0) <= I*

function func(du, u, p, t)
	S,I,R = u
	du[1] = 0
	du[2] = -b*u[2]
	du[3] = b*u[2]
end

v0 = [S0, I0, R0]
tspan  = (0.0,55.0)
problem = ODEProblem(func, v0, tspan)
solution = solve(problem, dtmax=0.05)
S=[u[1] for u in solution.u]
I=[u[2] for u in solution.u]
R=[u[3] for u in solution.u]
T=[t for t in solution.t]

plt = plot(dpi=700, bg=:lightgrey, legend=true)
plot!(plt, title=:"Случай 1: I(0) <= I*", legend=:right)
plot!(plt, T, I, label="Распространители болезни", color=:red)
plot!(plt, T, S, label="Особи, вопсприимчивые к болезни", color=:blue)
plot!(plt, T, R, label="Особи с иммунитетом к болезни", color=:green)

savefig(plt, "lab6_1.png")