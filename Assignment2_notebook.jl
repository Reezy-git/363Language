### A Pluto.jl notebook ###
# v0.19.9

using Markdown
using InteractiveUtils

# ╔═╡ bd5cc7a8-be2f-44dc-b3b6-1a07356a547b
using PlutoUI

# ╔═╡ 578dc500-3ecd-11ed-2c21-33a943d62abb
md"""

# **MATH363-22S2** - _Assignment 2_

## _Language Revitalisation Modeling_

`Due Date`: **Monday, 10 October 2022, 5:00 PM**

`Submission by`: Richard Hodges

`Student ID`: 11139318

All programming is done in Julia and the code and full size images will be available at: 

`http://github.com/Reezy-git/363Language`
"""

# ╔═╡ 6dc760cf-aade-4b19-b863-a693790ba2bf
md"""
### Abstract 

Around the world there are many languages listed as endangered in particular in New Zealand the use of te reo Māori has seen a significant decline since colonisation and settlement of Europeans. There are a number of reasons why language diversity is considered important such as the language-culture link and enhanced social development [2,9] as such the preservation of existing languages such as te reo Māori should take precedence.

This assignment explores through mathematical modeling the rates at which language death and revival can occur. With the goal of finding whether or not a language will become extinct or flourish in the long term and the required system parameters for this to occur. We use bifurcation analysis of our proposed ODE systems to achieve this.

There exists a level for each language based on the learning and acquisition rates for above which it will be self sustaining and reach a fixed point at which it is used and below which it will reach the fixed point related to extinction. Similarly, there exists a set of learning rates above the threshold given a non-zero starting population of speakers will lead to self sustained growth of a language to the fixed point at which it is used and below which it will reach the fixed point related to extinction.

###### Policy Implications

When a language is on the trajectory towards extinction additional support to alter the language acquisition rates in the short term may be enough to push the trajectory toward a stable existent future. Once the population reaches it's critical threshold language acquisition is predicted to be self-sustaining therefore the support for revitalisation required is finite. Unless the long term acquisition rates are too low in which case no remedy short of improving these will see a result differing from extinction.
"""

# ╔═╡ 4e348f5b-e364-4e9e-b787-5704810f6ad2
md"""
### Introduction 

With approximately 7000 languages currently spoken around the world [1] and the present prediction that 50-90% of these will be extinct by 2100 [8]. We stand to preserve a significant amount of language and therefore cultural diversity [2] by protecting the already existing 7000 languages. In order to effectively preserve language diversity, we must understand the forces in play and explore potential critical tipping points (in this case we look at bifurcations) within the system. It is hypothesised that once a certain percentage of the population reaches proficiency in the language the revitalisation will become self sustaining resulting in a thriving language and subsequently culture. 
"""

# ╔═╡ 264651b9-ace7-4656-b4d9-29313e8b0af8
md"""
As with anything there are different levels of mastery within language acquisition. The Common European Framework of Reference for Languages suggests 3 broad levels of language mastery: Basic, Independent and Proficient [6]. As such, we will break our population into 3 sub populations in relation to their language mastery levels and describe the transition rates between them similar to Barrett-Walker [4]. The model we use is not one of Lokta-Volterra style competition where one language is competing for dominance, as is discussed by Baggs [7] instead considering languages to be non-predatory in nature. We find that the trajectory of a language is either toward extinction or that of a non-zero-use steady state and is entirely dependent on the initial conditions.
"""

# ╔═╡ 324a816e-487a-46d7-8d06-4c6d69e62991
md"""
We find that for te reo Māori with the estimated learning rates in this assignment, we would expect that even with a population of 100% proficiency the language would die. In 2013 we had a proficient population of merely 10.6% [4] and so if te reo Māori is to survive long term, there needs to be an inrease of the learning rates. No other factor will change the long term outcome, $\beta=\gamma=0.03$ is simply too low for the language to survive.
"""

# ╔═╡ a3249ec7-c613-4ba0-b640-77f3ad81237f
md"""
### Model 

In this model we make a few assumptions. Firstly, our overall population, $\,N\,$ is static, i.e. birth rates are equal to death rates and total population $\,N=1\,$ this allows us to view the different proficiency levels are a percentage of the total population. We also assume that individuals move from the basic category to the independednt to the proficient category without the ability to lose proficiency or skip a category. Below in figure 1 we see the proposed structural causal model (SCM) for the language acquisition.
"""

# ╔═╡ f7f1dd51-90bf-43c7-bcf4-4eda4ad85adf
md"""
$(LocalResource("/home/reezy/Julia Code/Dynamical Systems/Assignment2/SCM.png"))
`Figure 1 - The SCM represented as a digraph.`
"""

# ╔═╡ 6083dfe7-6ff4-4d9c-9c60-25bbcdb6f294
md"""
We therefore can construct the following models:

For the Basic users, we observe the rate of change is driven by births at a rate of $\,r\,$ where all offspring of basic and independent users are assumed to be basic users, and a certain percentage of proficient users baby's are proficient leaving the remainder in the basic category. Basic users can transition to independent users at a learning rate of $\,\beta\,$ dependent on the population of basic and proficient users $\,B\,\&\,P\,$ and finally the basic population suffers a death rate of $\,r\,$ this gives:

$\frac{dB}{dt}=r(B+I+(1-\alpha)P)-\beta BP-rB$
"""

# ╔═╡ c971b4ee-17b7-4d6c-9a7c-12df5111f4d1
md"""
The change in independent users is driven by the transition from basic to independent $\,\beta BP\,$ the transition rate from independent to proficient $\,\gamma IP\,$ and of course the death rate. This gives:

$\frac{dI}{dt}=\beta IP - \gamma IP -rI$
"""

# ╔═╡ df142ec3-cac5-4434-84b4-e67c117eb967
md"""
Finally the change in proficient users is driven by the percentage of proficiency acquired at birth $\,\alpha\,$ the transition from independent to proficient $\,\gamma IP\,$ and the death rate.

$\frac{dP}{dt}=r\alpha P+\gamma IP -rP$
"""

# ╔═╡ 231e2b67-473e-413e-abeb-cfc71751cd4a
md"""
Research in [3-5] suggests that appropriate values for these variables may be near:

$\alpha= .47 \quad \beta=0.03 \quad \gamma=0.03 \quad r=\frac{1}{80}$
"""

# ╔═╡ e8572de2-30cc-456f-8652-805bff129175
md"""
For the simplicity of the model we will assume that $\gamma=\beta$ that is to say that independent learners are half way to fluency.
"""

# ╔═╡ c82773ae-b017-42f3-b24c-3b096619b16e
md"""
Since we have fixed our population size to $N=1$ we can observe that $B=1-I-P$ and as such we can reduce our model to the following two equations with the remaining population falling into category $B$.

$\quad\quad\quad\;\;\;\frac{dP}{dt}=r\alpha P +\gamma IP-rP\quad,\quad\frac{dI}{dt}= \beta(1-P-I)P-\gamma IP -rI\quad\quad\quad(1)$
"""

# ╔═╡ 845f5f3f-6a88-431c-992f-f8246831a2a9
md"""
### Results 

With a little algebra we can work out the null clines from $(1)$ as:

$null(I)\Rightarrow\beta P^{*2}+(\beta (I-1)+\gamma I)P^* -rI=0$
$null(P)\Rightarrow I^*=\frac{(1-\alpha)r}{\gamma}$


"""

# ╔═╡ dd1c0da0-6d1c-495c-b349-ec3efbb6db7b
md"""
There are fixed points when both systems in $(1)=0$ that is $(I^*,P^*)=(0,0)$ and when the null clines are equal. 

$\Rightarrow\;(I^*,P^*)=(0,0) \quad or\quad \left(\frac{(1-\alpha)r}{\gamma},\frac{-b\pm\sqrt{b^2-4\beta c}}{2\beta}\right)$
"""

# ╔═╡ c9e85660-159f-431a-9519-ea8c18bc3b90
md"""
Where:

$b := \beta(\frac{(1-\alpha)r}{\gamma}-1)+(1-\alpha)r \quad\&\quad c:=\frac{r^2(1-\alpha)}{\gamma}$
"""

# ╔═╡ 90f80c57-472b-4568-a824-558390ec1d4e
md"""
We can observe from this a saddle node bifurcation occurring along $b^2=4\beta c$ as a result of the square root. i.e. $\beta=\gamma\approx0.03145$ ignoring the negative solution as it is nonsensical in this context.
"""

# ╔═╡ 8c9a3605-2ea8-4191-989e-0111bfcc67ee
md"""
A useful visualisation of the model is to construct streamplot (vector field) of the system with a few perturbations of the parameters.  In this case we will observe the perturbation of $\beta=\gamma$ the acquisition rates see figure 2.
"""

# ╔═╡ 0c027549-25d7-4c89-b67d-81d070817870
md"""
$(LocalResource("/home/reezy/Julia Code/Dynamical Systems/Assignment2/Language_streamplots.png"))
`Figure 2 - Vector field of the ODE system with various parameter levels (NOT phase portraits) We see in 2.1 only one fixed point exists at the origin. In 2.2 and 2.3 two additional fixed points exist a saddle and a stable node.`
"""
# figure 2, 3-panels of different alphas

# ╔═╡ 82a6b834-67bf-45bd-aab4-ffc767d39a44
md"""
Looking at these streamplots we can observe that for $\beta=\gamma=0.03$ (figure 2.1) there is only one stable fixed point at the origin. But once we increase our acquisition rates a new stable fixed point occurs off the origin and a saddle node point occurs between them. Applying our initial conditions $(B,I,P)=	(.774,\;.120,\;.106)$ obtained from [4] for te reo Maori to these parameters we can observe the predicted outcomes for various learning rates see figure 3.
"""

# ╔═╡ e35369e7-61f6-4c13-b560-7edb5527bcff
md"""
$(LocalResource("/home/reezy/Julia Code/Dynamical Systems/Assignment2/plot_3_Lang_ODEsystems.svg"))
`Figure 3 - The behaviour of the language acquisition model at various acquistion rates. 3.1 shows the decline of the language toward extinction. 3.2 shows at the initial condition provided we are to stay at the saddle node. 3.3 the system is on a trajectory toward a stable node at P≈0.7`
"""

# Figure 3, 3 panels showing the longterm outcome with different parameters.

# ╔═╡ 85beab86-d7f7-438a-833f-c313d6f70c97
md"""
For the parameter values of $\alpha=\beta=0.03,\;\alpha=0.47\;r=\frac{1}{80}$ we can see what will happen if $(B,I,P)=(0,\;0,\;1)$ over a few thousand years see figure 4. This reflects what has happened as a result of colonialism. However, in the past 100-odd years the decline from 100% usage of te reo Maori among the Māori population has been more dramatic than observed in the system. Reducing to just 10.6% proficient users at this time.
"""

# ╔═╡ 1fb62b82-0bb5-4dbc-a0b6-979d6302cbb2
md"""
$(LocalResource("/home/reezy/Julia Code/Dynamical Systems/Assignment2/plot_10_03LRs_P0_1.svg"))
`Figure 4 - The behaviour of the language acquisition model at β=γ=0.03 with initial condition (B,I,P)=(0, 0, 1). The death of the language`
"""

# ╔═╡ c393f7ad-3e64-45f0-b75f-1e80f636f739
md"""
### Discussion 

We tested the hypothesis that once a certain percentage of the population reaches proficiency in the language the revitalisation will become self sustaining resulting in a thriving language and culture. Although one should notice that the previous statement fails to account for learning and intergenerational preservation rates, one should also note that in the long term these are essentially fixed by the attitudes of the community. Therefore, if a stable point for the language exists where there is a present population of speakers we need only to influence the rates for a finite period to reach a condition where the system will draw itself to such a fixed point. On the other hand, if the parameters of the system are such that there is no stable fixed point off the origin the language is doomed to extinction. Therefore the attitude of the target community for the endangered language needs to be the target of any revitalisation scheme in order to get the acquisition rates to increase. If this is not done expect the language to continue declining as it did in the past. Figure 4 demonstrates the effect of a low learning rate by demonstrating that even with 100% proficiency initial condition a language can and will still die off.


"""

# ╔═╡ fe4b8ed1-1e8a-4787-8c46-5b288a244778
md"""
Consistent with Barrett-Walker [4] this assignment predicts that in the current observed state te reo Māori will continue to decline to extinction. Assuming the 50-90% of existent languages predicted to see extinction in the next hundred years [8] are similar in nature serious grass roots community work needs to be done to alter the learning and acquisition rates for their target populations. Research by Bauer [10] suggests an even more dramatic drop in language usage than is observed in figure 4. Therefore one might suggest that the acquisition rates proposed by Barret-Walker [4] could be too optimistic, at least for the past 100 years since we can read from figure 4. that at 2013 there should have been ~60% Proficients however the data suggests $P=10.6\%$.
"""

# ╔═╡ b9c97675-3fc7-4e80-842d-46ec37510486
md"""
Without intervention we expect te reo Māori to continue to decline if the learning rates are in fact $\beta=\gamma\approx0.03$ we expect very little change if $\beta=\gamma\approx0.039$ and growth up to a point of $P\approx0.7$ if the acquisition rates are $\beta=\gamma\approx0.05$. Factors that can affect these rates are reported to be: language immersion programs, age of learners [11,12] among others. So if te reo Māori is to be preserved strategies along the lines of increasing availability of immersion programs such as schooling and the targeting of young children are likely to help. In order for a language to survive there needs to exist a non-zero fixed point and as we have seen this existence is reliant on the language's learning rates.
"""

# ╔═╡ a480eee4-1a76-4763-8b70-b1a9bf6839ce
md"""
### References

1. Austin, P. K., & Sallabank, J. (Eds.). (2011). The Cambridge handbook of endangered languages. Cambridge University Press


2. Glynn, T. (2015). Bicultural challenges for educational professionals in Aotearoa.


3. King, J., & Cunningham, U. (2017). Tamariki and fanau: Child speakers of maori and samoan in Aotearoa/New zealand. Te Reo, 60(60), 29-46. 


4. Barrett-Walker, T., Plank, M. J., Ka'ai-Mahuta, R., Hikuroa, D., & James, A. (2020). Kia kaua te reo e rite ki te moa, ka ngaro: Do not let the language suffer the same fate as the moa. Journal of the Royal Society Interface, 17(162), 20190526-20190526.


5. National interim life tables and subnational life expectancy, 2006-08. (2009). Population Trends, (138), 5.


6. Council of Europe. Common European framework of reference for languages: common reference levels. See http://www.coe.int/en/web/common-european-framework-reference-languages/table-1-cefr-3.3-common-reference-levels-global-scale.


7. Baggs, I. V. A. N., & Freedman, H. I. (1990). A mathematical model for the dynamics of interactions between a unilingual and a bilingual population: Persistence versus extinction. Journal of Mathematical Sociology, 16(1), 51-75.

8. Austin, P. K., & Sallabank, J. (Eds.). (2011). The Cambridge handbook of endangered languages. Cambridge University Press.


9. Fan, S. P., Liberman, Z., Keysar, B., & Kinzler, K. D. (2015). The exposure advantage: Early exposure to a multilingual environment promotes effective communication. Psychological Science, 26(7), 1090-1097.

10. Bauer, W. (2008). Is the Health of Te Reo Māori Improving? Te Reo, 51, 33-73.

11. Pearson, B. Z. (2007). Social factors in childhood bilingualism in the United States. Applied psycholinguistics, 28(3), 399-410.


12. Hartshorne, J. K., Tenenbaum, J. B., & Pinker, S. (2018). A critical period for second language acquisition: Evidence from 2/3 million English speakers. Cognition, 177, 263-277.


13. Christ, S., Schwabeneder, D., Rackauckas, C., Borregaard, M. K., & Breloff, T. (2022). Plots.jl -- a user extendable plotting API for the julia programming language.


14. Rackauckas, C., & Nie, Q. (2017). DifferentialEquations.jl – A performant and feature-rich ecosystem for solving differential equations in julia. Journal of Open Research Software, 5(1), 15.


15. Danisch, S., & Krumbiegel, J. (2021). Makie.jl: Flexible high-performance data visualization for julia. Journal of Open Source Software, 6(65), 3349.
"""

# ╔═╡ 7a4efee1-e513-4fba-82d1-359c9fd46b40
md"""

"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.43"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.3"
manifest_format = "2.0"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "3d5bf43e3e8b412656404ed9466f1dcbf7c50269"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.4.0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "2777a5c2c91b3145f5aa75b61bb4c2eb38797136"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.43"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "6bac775f2d42a611cdfcd1fb217ee719630c4175"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.6"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╟─578dc500-3ecd-11ed-2c21-33a943d62abb
# ╠═bd5cc7a8-be2f-44dc-b3b6-1a07356a547b
# ╟─6dc760cf-aade-4b19-b863-a693790ba2bf
# ╟─4e348f5b-e364-4e9e-b787-5704810f6ad2
# ╟─264651b9-ace7-4656-b4d9-29313e8b0af8
# ╟─324a816e-487a-46d7-8d06-4c6d69e62991
# ╟─a3249ec7-c613-4ba0-b640-77f3ad81237f
# ╟─f7f1dd51-90bf-43c7-bcf4-4eda4ad85adf
# ╟─6083dfe7-6ff4-4d9c-9c60-25bbcdb6f294
# ╟─c971b4ee-17b7-4d6c-9a7c-12df5111f4d1
# ╟─df142ec3-cac5-4434-84b4-e67c117eb967
# ╟─231e2b67-473e-413e-abeb-cfc71751cd4a
# ╟─e8572de2-30cc-456f-8652-805bff129175
# ╟─c82773ae-b017-42f3-b24c-3b096619b16e
# ╟─845f5f3f-6a88-431c-992f-f8246831a2a9
# ╟─dd1c0da0-6d1c-495c-b349-ec3efbb6db7b
# ╟─c9e85660-159f-431a-9519-ea8c18bc3b90
# ╟─90f80c57-472b-4568-a824-558390ec1d4e
# ╟─8c9a3605-2ea8-4191-989e-0111bfcc67ee
# ╟─0c027549-25d7-4c89-b67d-81d070817870
# ╟─82a6b834-67bf-45bd-aab4-ffc767d39a44
# ╟─e35369e7-61f6-4c13-b560-7edb5527bcff
# ╟─85beab86-d7f7-438a-833f-c313d6f70c97
# ╟─1fb62b82-0bb5-4dbc-a0b6-979d6302cbb2
# ╟─c393f7ad-3e64-45f0-b75f-1e80f636f739
# ╟─fe4b8ed1-1e8a-4787-8c46-5b288a244778
# ╟─b9c97675-3fc7-4e80-842d-46ec37510486
# ╟─a480eee4-1a76-4763-8b70-b1a9bf6839ce
# ╟─7a4efee1-e513-4fba-82d1-359c9fd46b40
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
