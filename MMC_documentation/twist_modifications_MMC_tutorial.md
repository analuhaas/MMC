# Recommended modifications in TWIST boards to use them as MMC modules

The recommended hardware modifications of TWIST boards of version 1.4.3 or lower to serve as an MMC module are listed in this document.

1) It is recommended for MMC use to configure the board to feed the 6 V auxiliary input externally with feeder completely disconnected from the electrical circuit of the board. This is prefered since the board feeder is not yet adapted to MMC charging phase. To do that:

- Open the jumper JP5001 of the board by cutting the jumper connections using a cutter with an appropriate camera to see the area

![Feeder jumper cut](figures\feeder_jumper_cut.png)

2) Up to version 1.4.3 of the boards, it is necessary to substitute the black/green fuses of the 6 V supply by 0 Ohms resistances of 1210 size.

- Identify the fuses placement with the help of KICAD. Open both the schematic editor and the PCB editor correpondent to your board version. For help to access TWIST/OWNVERTER KICAD, go to this [OwnTech's KICAD tutorial](owntech_kicad_tutorial.md).

- The fuses are represented by the 350 mA fuse symbol in the figure below. Click on the fuse symbol using the schematic editor and it will indicate the right location in the PCB editor.

![Find fuses placement with KICAD](figures\Module_adapt_6Vfuses_KICAD.png)

- Mount the 0 Ohms resistances in the place of the fuses. If you don't have 0 Ohms resistances, you can use small jumpers instead.

![Fuses substitution](figures\Module_adapt_6Vfuses.png)

- To test if the 0 Ohms resistances are well mounted, connect all boards 6 V inputs in series as shown in the figure below. Use a DC power supply configured for 6 V and current depending on the number of boards (1 board consumes ~0.3 on the 6 V input). TURN ON the DC power supply, you should see all boards LEDs light up.

![Fuses substitution test](figures\Module_adapt_6Vfuses_test.png)