# 1-D Transient Model of an Iron Ore Sinter Bed

A MATLAB-based model developed to understand how **heat, gas flow, combustion and species transport interact inside an iron ore sinter bed**.

The project started with a 1-D steady-state representation of the bed and was then extended into a transient model so that the movement of the combustion zone could be followed with time. The longer-term objective was to use the model as a base for studying **gaseous fuel injection for lower-carbon sintering**.

## What I Modelled

The sinter bed is treated as a 1-D domain along its height. The transient model solves for the major variables that control the process:

* Solid temperature
* Gas temperature
* Oxygen concentration
* CO₂ concentration
* Coke concentration
* Moisture content
* Local coke combustion rate

The bed is discretized into **61 nodes over a 0.60 m height** and the simulation is advanced in time using an explicit finite-difference scheme.

## Numerical Approach

The governing equations contain both spatial and time derivatives, so I used:

* **First-order upwind difference** for convective terms
* **Central difference** for second-order conduction terms
* **Explicit Euler time integration**
* A modular MATLAB structure for the individual physical processes

The main solver advances the solution sequentially through combustion, oxygen and CO₂ transport, moisture evaporation, gas-phase energy and solid-phase energy.

This modular approach made it easier to add or modify individual parts of the model without rewriting the entire solver.

## Combustion Model

Coke combustion is represented using an Arrhenius-type rate expression. The local reaction rate depends on:

* Temperature
* Coke concentration
* Oxygen concentration

The combustion rate is then coupled back into the solid energy equation as a heat-generation term and into the species balances through oxygen consumption and CO₂ generation.

Moisture evaporation is also coupled to the energy balance through its latent heat requirement.

## Results

The transient model captures the development and downward movement of the combustion zone through the bed.

For the simulated case, the model predicts:

* Peak temperatures of approximately **1200 K**
* Flame-front progression to approximately **0.20 m** during the simulation
* Initial coke concentration of approximately **4 wt%**
* Coke depletion to approximately **1.4–2 wt%** in the region already traversed by the combustion front

The temperature histories at different bed depths also show the expected time delay as the thermal/combustion front moves downward.

## What the Model Shows

One of the main things I wanted to capture was that sintering is not simply a steady heat-transfer problem. The combustion zone is a **moving reaction front**, and the local temperature, oxygen availability and coke concentration continuously influence one another.

This is why the model couples the energy and species balances rather than treating them independently.

## Code Structure

```text
main.m
transient_solver.m
initial_parameters.m
initialize_state.m

update_combustion.m
compute_solid_energy.m
compute_gas_advection.m
compute_gas_velocity.m

compute_oxygen_transport.m
compute_CO2_transport.m
compute_species.m
compute_moisture.m

store_history.m
```

`transient_solver.m` acts as the numerical backbone of the model, while the individual `compute_*.m` files handle the corresponding physical processes.

## Future Extension: Gaseous Fuel Injection

The main reason for developing the model in a modular form was to make it possible to extend it toward **low-carbon sintering**.

The existing framework can be extended to introduce gaseous fuels such as:

* H₂
* CO
* Coke Oven Gas
* Syngas
* Natural Gas

The next stage would involve adding the corresponding species balances, reaction kinetics and heat-release terms and then studying how fuel injection changes flame-front movement, temperature distribution and coke consumption.

## Tools

**MATLAB | Finite Difference Methods | Heat Transfer | Mass Transfer | Reaction Engineering | Process Modelling**

Developed as part of my summer research internship at **RDCIS, SAIL, Ranchi**.
