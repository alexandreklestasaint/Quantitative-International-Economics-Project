# The Impact of the WTO on Bilateral Trade

Team project for the Quantitative International Economics course, M2 at Université Paris Dauphine-PSL, by Alexandre Saint, Inès Kemicha and Louise Le Grusse (January 2026).

## Research question

Does joint membership of the World Trade Organization (WTO) increase trade between two countries, and does the effect differ with the development level of the partners?

## Data

| Source | Content | Access |
|---|---|---|
| USITC Dynamic Gravity Dataset (DGD), release 2.1 | WTO/GATT membership, trade agreements, distance, language, contiguity, colonial ties, GDP | [usitc.gov/data/gravity/dgd.htm](https://www.usitc.gov/data/gravity/dgd.htm) |
| USITC International Trade and Production Database for Estimation (ITPDE), release 3 | Bilateral trade flows, including zeros and domestic flows | [usitc.gov/data/gravity/itpde.htm](https://www.usitc.gov/data/gravity/itpde.htm) |
| Gravity_M2IT | World Bank income group of each country | Provided in the course, not redistributable |

USITC is the United States International Trade Commission. The estimation sample covers 2000-2018 (2019 drops out because of missing data): 658,966 observations, 198 countries and 36,200 country pairs. Raw data (about 11 GB) are not included in the repository.

## Method

Structural gravity model estimated by Poisson pseudo-maximum likelihood (PPML) with `fixest`:

- exporter-year and importer-year fixed effects, to absorb multilateral resistance;
- country-pair fixed effects, so that the WTO effect is identified only from pairs whose joint membership changes during the period;
- international border dummies interacted with years, to control for globalization;
- a free trade agreement dummy;
- heterogeneity: the WTO dummy is interacted with six pair types built from the development level of each partner (High, Intermediate, Low: HH, HI, HL, II, LI, LL).

A traditional specification without pair fixed effects (with distance, language, contiguity and colonial ties) is reported for comparison. Standard errors are clustered by exporter and importer.

## Main results

| | Traditional | Structural |
|---|---|---|
| Both WTO members | 1.917*** (0.276) | -0.197* (0.103) |
| Free trade agreement | -0.939*** (0.167) | 0.172*** (0.062) |
| Observations | 658,966 | 646,149 |

\* p < 0.1, \*\* p < 0.05, \*\*\* p < 0.01.

- Without pair fixed effects, joint membership is associated with much higher trade. The estimate mainly reflects time-invariant differences between pairs.
- With pair fixed effects, the WTO coefficient is -0.197 and significant only at the 10% level: we find no evidence that the accessions of 2000-2018 raised trade with existing members. Free trade agreements raise trade by about 19%.
- By pair type, the structural coefficients are negative for pairs involving a high-income country (HH: -0.373***, HL: -0.427**) and not significant for the other types.
- The results are robust to a full set of border-year controls.

The full set of tables, the discussion and the limitations are in [`wto_gravity_ppml.pdf`](wto_gravity_ppml.pdf).

## How to reproduce

1. Install R (tested with R 4.5.1) and Quarto (tested with 1.9), with a LaTeX distribution such as TinyTeX.
2. Install the packages:
   ```r
   install.packages(c("tidyverse", "fixest", "modelsummary", "kableExtra", "data.table", "haven"))
   ```
   Versions used: tidyverse 2.0.0, fixest 0.14.1, modelsummary 2.6.0, kableExtra 1.4.0, data.table 1.17.8, haven 2.5.5.
3. Download the data and place them in a `Data/` folder at the root of the repository:
   ```
   Data/
   ├── Gravity_M2IT.dta
   ├── ITPDE_R03.csv
   ├── release_2.1_2000_2004.csv
   ├── release_2.1_2005_2009.csv
   ├── release_2.1_2010_2014.csv
   └── release_2.1_2015_2019.csv
   ```
4. Render the document:
   ```
   quarto render wto_gravity_ppml.qmd --to pdf
   ```
   The ITPDE file is about 8 GB. Rendering took about 15 minutes on a machine with 32 GB of RAM.

## Repository structure

```
.
├── README.md
├── wto_gravity_ppml.qmd   # source: data preparation, estimation, tables and text
├── wto_gravity_ppml.pdf   # rendered document
└── .gitignore             # excludes Data/ and build files
```
