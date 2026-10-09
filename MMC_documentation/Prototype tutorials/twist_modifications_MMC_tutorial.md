# Recommended modifications in TWIST boards to use them as MMC modules

The recommended hardware modifications of TWIST boards of version 1.4.3 or lower to serve as an MMC module are listed in this document.

## Disconnect the internal APS from the power circuit

It is recommended for MMC use to configure the board to feed the 6 V auxiliary input externally with internal APS completely disconnected from the electrical circuit of the board. To do that:

- Open the jumper JP5001 of the board by cutting the jumper connections using a cutter with an appropriate camera to see the area
<img src="../figures/feeder_jumper_cut.png" alt="Feeder jumper cut" width="800"/>

This is prefered since the board internal APS is not yet adapted to MMC charging phase, as explained below:

>The APS powers the auxiliary circuits of the module such as sensors, communication devices, gate drivers that commands the switching cells, etc. The APS is also called as Control power system (CPS) and Self-power supply in the literature. In the OwnTech suite, its called Feeder. 
>
>The APS can be fed externally by an DC isolated source or by the module capacitor. In our final prototype solution, we count to power the APS via the module capacitor. In this configuration, the APS can only start working when a minimum voltage is supplied by the capacitor. 
>
>The figure below shows an example of the APS influence during the startup of the MMC prototype. This test was done with 3 TWIST/SPIN modules (B2, B3, B5) connected in series. After simply applying a DC voltage on the converter DC terminals, we observe that while modules B2 and B5 charges, the module B3 discharges. This difference is likely related to a consumption difference between the modules APS.
>
> <img src="../figures/APS_problem.png" alt="APS influence in capacitors charging" width="600"/>
>
>This problem is currently being treated for the future version of the prototype. 

## Substitute the 6V input fuses by 0 Ohms resistances

Up to version 1.4.3 of the boards, it is necessary to substitute the black/green fuses of the 6 V supply by 0 Ohms resistances of 1210 size. To do it, follow the steps:

- Identify the fuses placement with the help of KICAD. Open both the schematic editor and the PCB editor correpondent to your board version. For help to access TWIST/OWNVERTER KICAD, go to this [OwnTech's KICAD tutorial](../Getting%20started/owntech_kicad_tutorial.md).

- The fuses are represented by the 350 mA fuse symbol in the figure below. Click on the fuse symbol using the schematic editor and it will indicate the right location in the PCB editor.
<img src="../figures/Module_adapt_6Vfuses_KICAD.png" alt="Find fuses placement with KICAD" width="800"/>

- Mount the 0 Ohms resistances in the place of the fuses. If you don't have 0 Ohms resistances, you can use small jumpers/wires instead.
<img src="../figures/Module_adapt_6Vfuses.png" alt="Fuses substitution" width="800"/>

- To test if the 0 Ohms resistances are well mounted, connect all boards 6 V inputs in series as shown in the figure below. Use a DC power supply configured for 6 V and current depending on the number of boards (1 board consumes ~0.3 on the 6 V input). TURN ON the DC power supply, you should see all boards LEDs light up.

<img src="../figures/Module_adapt_6Vfuses_test.png" alt="Fuses substitution test" width="800"/>

This is modification facilitates the implementation of modular topologies, as explained below:

>The auxiliary circuits of the board are protected from possible high currents in the 6V input by fuses of 350 mA. However, since two fuses are placed just after the 6V IN and the DGND pins, they limit not only the current that goes to the board auxiliary circuits, but also the current that flows to other boards 6V inputs if connected in chain configuration, as shown in the figure below.
>
> <img src="../figures/MMC_6V_supply_chain.png" alt="6V supply with chain configuration" width="400"/>
>
>Since the auxiliary circuits of 1 board consumes around 260 mA, it is not possible to connect even 2 modules in a chain. That's why the substitution by 0 Ohms resistances is used.
>
>This problem can be easily diagnosed by observing if the modules LED's are in their full bright after connecting them to the 6 V external supply.
>
>This is a provisory solution. This problem is currently being treated for the future version of the prototype. 

## Remove $C_{Low1}$ ceramic capacitor of the circuit

The $C_{Low1}$ capacitor is composed of 1 electrolytic capacitor and 3 ceramic capacitors in parallel. The electrolytic capacitor can be removed from the circuit via software openning Q5 MOSFET. However, the ceramic capacitors are directly soldered to the circuit.

To have a behavior closer to an MMC, we remove the ceramic capacitors from the board. To do that:

- Identify the capacitors placement with the help of KICAD. Open both the schematic editor and the PCB editor correpondent to your board version. For help to access TWIST/OWNVERTER KICAD, go to this [OwnTech's KICAD tutorial](../Getting%20started/owntech_kicad_tutorial.md).

- The ceramic capacitors are accross V1Low and GND terminals and are represented the symbol in the figure below. Click on the capacitor symbol using the schematic editor and it will indicate the right location in the PCB editor.
<img src="../figures/Position_CLow1_PCB.png" alt="Find capacitor placement with KICAD" width="1000"/>

- Remove the capacitors by using 2 soldering irons on the capacitors sides. It takes quite some time to remove it cause the ground zone dissipates a lot of heat. Do it for the 3 ceramic capacitors. No need to remove the eletrolytic capacitor !
<img src="../figures/removed_CLow1.png" alt="Capacitors removal" width="400"/>

>The main issue from this capacitor presence in the circuit is that $C_{Low1}$ capacitor forms a LC filter with $L_1$ inductance. This causes a high-frequency oscillations in the beginning of the arm voltage steps, as shown in the figure below.
>
><img src="../figures/exp_phase_LC_oscillations.png" alt="Oscillations due to LC circuit" width="400"/>
>
>As this behavior is not usual for an NLM MMC, it is recommended to remove this capacitor.

## Increase bootstrap circuit capacitance

The bootstrap capacitor is not sufficient for 50 Hz operation. To increase it, we add extra capacitances in parallel. To do that:

- Identify the bootstrap capacitor placement with the help of KICAD. Open both the schematic editor and the PCB editor correpondent to your board version. For help to access TWIST/OWNVERTER KICAD, go to this [OwnTech's KICAD tutorial](../Getting%20started/owntech_kicad_tutorial.md).

- The bootstrap capacitors are close to the driver and are represented the symbol in the figure below. Click on the capacitor symbol using the schematic editor and it will indicate the right location in the PCB editor.
<img src="../figures/Position_bootstrap_PCB.png" alt="Find capacitor placement with KICAD" width="1000"/>

- Add the additional capacitors by using 1 soldering irons to sold the capacitors above the original one. For our prototype, we added 1 capacitor of 33 $\mu$F and 1 capacitor of 22 $\mu$F, having 3 capacitors stacked as shown in the figure below.
<img src="../figures/boostrap_capacitors_parallel.png" alt="Extra bootstrap capacitors" width="400"/>

The extra capacitors used were bought at RS components with references 916-2914 and 242-7416. If you use other capacitors, make sure they are correspondent in size.

>The main issue from this low bootstrap capacitance is that the modules can't stay long time in connected state, passing to blocked state during operation. This causes a incontrollability of the converter and the stack voltage becomes uncorrelated to capacitors voltage as shown in the figure below.
>
><img src="../figures/difference_vc_vm_bootstrap.png" alt="Bootstrap capacitance impact on stack voltage" width="500"/>
>
>We verified that this behavior is related to the bootstrap circuit by measuring the Vgs (gate to source) voltage of Q1 MOSFET while the module switches at a 50 Hz frequency. We can see that, since the boostrap capacitor is small, Vgs discharges fast, making the module pass to blocked state while it is commanded to be at connected state.
>
><img src="../figures/bootstrap_problem.png" alt="Vgs discharge with small bootstrap capacitor" width="700"/>
>
>As this behavior is not usual for an NLM MMC, it is recommended to increase the bootstrap capacitance. However, the bootstrap circuit is not the best solution for operating at NLM and a better solution is in course of development.

## Increase module capacitance

The high-side capacitor $C_{High}$ is used as the module capacitor. Its capacitance of 188.6 $\mu$F is quite small and does not sustain enough energy for operation with power at 50 Hz.

<img src="../figures/Twist_programmed_as_HB_module_tutorial.png" alt="Twist software-defined as a Half-bridge module" width="1000"/>

To do that, it suffices to connect capacitors in parallel to $C_{High}$ using VHigh and GND terminals. We make available the [PCB KiCad project](KiCad_module_capacitor/Condensateur_Ana251211) used to add up to 4 560 µF capacitors of CHEMICON in parallel of reference 914-3692 at RS components. If you use other capacitor, make sure to adapt the capacitor holes size and spacement on the PCB. The final result is a tower stacking multiple capacitors, like shown in the figure below, that can be accomodates on the side of each stack.

<img src="../figures/stack_with_capacitor_tour.jpeg" alt="Capacitor tour to increase module capacitance" width="400"/>

>The main issue from this low capacitance is that the capacitors charges and discharges fast as shown in the figure below. This causes higher voltage ripple and a deformed stack voltage.
>
><img src="../figures/stack_behavior_small_capacitor.png" alt="Small capacitor impact on stack behavior" width="700"/>
>
>As this behavior is not usual for an NLM MMC, it is recommended to increase the module capacitance.