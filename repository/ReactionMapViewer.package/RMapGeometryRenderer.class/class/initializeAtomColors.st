class initialization
initializeAtomColors
	"RMapGeometryRenderer initializeAtomColors"
	AtomColors := Dictionary new.
	AtomColors at: 'H' put: Color white.
	AtomColors at: 'He' put: (Color r: 0.85 g: 1.0 b: 1.0).
	AtomColors at: 'Li' put: (Color r: 0.607 g: 0.38 b: 0.761).
	AtomColors at: 'Be' put: (Color r: 0.638 g: 0.839 b: 0.0).
	AtomColors at: 'B' put: (Color r: 1.0 g: 0.71 b: 0.71).
	AtomColors at: 'C' put: (Color r: 0.5640000000000001 g: 0.5640000000000001 b: 0.5640000000000001).
	AtomColors at: 'N' put: (Color r: 0.188 g: 0.313 b: 0.972).
	AtomColors at: 'O' put: (Color r: 1.0 g: 0.051000000000000004 b: 0.051000000000000004).
	AtomColors at: 'F' put: (Color r: 0.5640000000000001 g: 0.878 b: 0.313).
	AtomColors at: 'Ne' put: (Color r: 0.7020000000000001 g: 0.89 b: 0.96).
	AtomColors at: 'Na' put: (Color r: 0.671 g: 0.361 b: 0.9480000000000001).
	AtomColors at: 'Mg' put: (Color r: 0.541 g: 1.0 b: 0.0).
	AtomColors at: 'Al' put: (Color r: 0.749 g: 0.65 b: 0.65).
	AtomColors at: 'Si' put: (Color r: 0.9400000000000001 g: 0.784 b: 0.627).
	AtomColors at: 'P' put: (Color r: 1.0 g: 0.501 b: 0.0).
	AtomColors at: 'S' put: (Color r: 1.0 g: 1.0 b: 0.188).
	AtomColors at: 'Cl' put: (Color r: 0.121 g: 0.9400000000000001 b: 0.121).
	AtomColors at: 'Ar' put: (Color r: 0.501 g: 0.8190000000000001 b: 0.89).
	AtomColors at: 'K' put: (Color r: 0.56 g: 0.25 b: 0.8310000000000001).
	AtomColors at: 'Ca' put: (Color r: 0.23900000000000002 g: 1.0 b: 0.0).
	AtomColors at: 'Sc' put: (Color r: 0.901 g: 0.901 b: 0.901).
	AtomColors at: 'Ti' put: (Color r: 0.749 g: 0.761 b: 0.78).
	AtomColors at: 'V' put: (Color r: 0.65 g: 0.65 b: 0.671).
	AtomColors at: 'Cr' put: (Color r: 0.541 g: 0.599 b: 0.78).
	AtomColors at: 'Mn' put: (Color r: 0.611 g: 0.47800000000000004 b: 0.78).
	AtomColors at: 'Fe' put: (Color r: 0.878 g: 0.4 b: 0.199).
	AtomColors at: 'Co' put: (Color r: 0.9400000000000001 g: 0.5640000000000001 b: 0.627).
	AtomColors at: 'Ni' put: (Color r: 0.313 g: 0.8150000000000001 b: 0.313).
	AtomColors at: 'Cu' put: (Color r: 0.784 g: 0.501 b: 0.199).
	AtomColors at: 'Zn' put: (Color r: 0.49 g: 0.501 b: 0.6900000000000001).
	AtomColors at: 'Ga' put: (Color r: 0.761 g: 0.56 b: 0.56).
	AtomColors at: 'Ge' put: (Color r: 0.4 g: 0.56 b: 0.56).
	AtomColors at: 'As' put: (Color r: 0.741 g: 0.501 b: 0.89).
	AtomColors at: 'Se' put: (Color r: 1.0 g: 0.63 b: 0.0).
	AtomColors at: 'Br' put: (Color r: 0.65 g: 0.16 b: 0.16).
	AtomColors at: 'Kr' put: (Color r: 0.361 g: 0.721 b: 0.8190000000000001).
	AtomColors at: 'Rb' put: (Color r: 0.439 g: 0.18 b: 0.6900000000000001).
	AtomColors at: 'Sr' put: (Color r: 0.0 g: 0.788 b: 0.0).
	AtomColors at: 'Y' put: (Color r: 0.58 g: 1.0 b: 1.0).
	AtomColors at: 'Zr' put: (Color r: 0.58 g: 0.878 b: 0.878).
	AtomColors at: 'Nb' put: (Color r: 0.451 g: 0.761 b: 0.788).
	AtomColors at: 'Mo' put: (Color r: 0.328 g: 0.71 b: 0.71).
	AtomColors at: 'Tc' put: (Color r: 0.231 g: 0.619 b: 0.619).
	AtomColors at: 'Ru' put: (Color r: 0.14100000000000001 g: 0.56 b: 0.56).
	AtomColors at: 'Rh' put: (Color r: 0.039 g: 0.49 b: 0.548).
	AtomColors at: 'Pd' put: (Color r: 0.0 g: 0.41200000000000003 b: 0.521).
	AtomColors at: 'Ag' put: (Color r: 0.753 g: 0.753 b: 0.753).
	AtomColors at: 'Cd' put: (Color r: 1.0 g: 0.85 b: 0.56).
	AtomColors at: 'In' put: (Color r: 0.65 g: 0.458 b: 0.451).
	AtomColors at: 'Sn' put: (Color r: 0.4 g: 0.501 b: 0.501).
	AtomColors at: 'Sb' put: (Color r: 0.619 g: 0.388 b: 0.71).
	AtomColors at: 'Te' put: (Color r: 0.8310000000000001 g: 0.47800000000000004 b: 0.0).
	AtomColors at: 'I' put: (Color r: 0.58 g: 0.0 b: 0.58).
	AtomColors at: 'Xe' put: (Color r: 0.258 g: 0.619 b: 0.6900000000000001)