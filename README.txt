Le compilateur contient les parties obligatoires ainsi que l'intégralité des bonus demandés.

Partie 1.1:
Break, continue et for sont traités dans le lexer, le parser et tous les fichiers de traduction.
L'interpréteur est contenu dans le fichier GotoInterpreter.ml et la fonction interpret_goto attend l'arbre en Goto et un argument.

Partie 1.2:
L'utilisation des instruction combinées a été faite dans translate_expression_aux dans GotoToMips.
La simplification des expressions arithmétiques a été faite dans translate_expression dans ImpToGoto.
L'utilisation réduite de la pile, la précalculation des adresses et l'utilisation des registres t2 à t9 est faite dans translate_expression_aux et binop.
J'ai gardé dans le code seulement la version finale.

Partie 2.1:
Le lexer SourceLexer.mll reconnait le langage Imp ainsi que les commentaires longs comme demandé en bonus.
En cas d'erreur, il affiche la position et le caractère erroné.
Le préprocesseur gère les macros avec ou sans arguments et produit un fichier .pp.cid expansé.
SourceIndentLexer.mll est le lexer basé sur l'indentation qui génère des tokens accolades et semi si besoin.
A noter que ce lexer n'est pas forcément compatible avec le sucre syntaxique du if de la partie 2.2

Partie 2.2;
L'analyseur syntaxique reconnait l'ensemble du langage ainsi que le sucre syntaxique
On peut déclarer plusieurs variables en même temps avec potentiellement des affectations.
On peut déclarer un if sans else ou suivi de elif
La boucle for est implémentée
L'affectation de plusieurs variables se fait de la manière suivante :
x,y = e1,e2 va donner
_x = e1
_y = e2
x = _x
y = _y
Cela évite que les variables soient modifiées et puisque les variables sont composées de caractères alphabétiques, on n'a aucun risque de conflit
Les messages d'erreur détectent les accolades manquantes, les parenthèses manquantes ou en trop, les else ou les virgules manquantes ainsi que plus généralement 
toute déclaration, instruction ou expression mal formée.
Il reste 5 conflits shift/reduce sur le mot-clé error qui sont liés au fait que la règle instruction peut être vide mais cela ne gêne pas la compilation
L'extension corrigée est la déclaration multiple de variables, il manquait la liste des variables temporaires à déclarer dans la liste des symboles

Partie 3.1:
La vérification des bornes se fait dans GotoToMips avec deux tests à chaque accès à un bloc
Il est possible de définir des tableaux à n dimensions initialisés ou non, c'est géré dans SourceParser
L'égalité logique est traitée à deux endroits : dans TypedToImp (bonus du 3.2), on remplace par false si les types sont différents
Dans GotoToMips, il y a une fonction logic_equality qui prend en arguments les deux éléments à comparer et leur type et renvoie vrai ou faux
On trouve donc aussi dans GotoToMips la distinction valeurs/pointeurs et les en-têtes étendus
Finalement, Malloc, Free et la gestion automatique Mark&Sweep sont gérées avec 5 fonctions en assembleur :
	-> malloc
	-> free
	-> expand_memory
	-> mark
	-> sweep
Pour cette extension, la mémoire allouée est de base 500 octets puis est étendue de 500 octets à chaque fois que les malloc ont rempli la mémoire allouée.
Les tableaux peuvent être initialisés dans une déclaration de variables multiple.

Partie 3.2:
L'entrelacement des déclarations est géré dans SourceParser
La gestion des champs immuables s'est faite dans le Parser et dans SourceToTyped avec la création d'une instruction InitSet.
Cette instruction indique que c'est une initialisation et ne provoquera pas d'erreur sur un champ immuable. Une fois en Imp, InitSet redevient un Set.
L'égalité logique ayant été traitée en MIPS, elle fonctionne pour les structures. Elle a été légèrement modifié pour traiter les étiquettes des structures union.
Le remplacement de TypeChecker par SourceToTyped et TypedToImp a été effectué.
Toute l'extension des unions étiquetées ainsi que les extensions de l'extension ont été réalisées.
Pour modéliser les structs union, dans la table des structures, on stocke pour chaque structure normale son nom et ses champs.
Pour une structure union, on stocke pour chaque étiquette le nom de la structure et ses champs.
On a une deuxième table à côté qui stocke les listes d'étiquettes de chaque structure union.
Les structures unions peuvent être créées initialisées (modélisé par une assignation normale puis un switch avec le cas de l'étiquette où on fait les assignations et un cas default vide)
Pour les switch, il faut une absence de redondance et soit que les cas soient exhaustifs, soit qu'il y ait un cas par défaut.
L'étiquette est dans l'en-tête.
La gestion des switch se fait avec la création d'une table de sauts quand on rencontre le switch.
Il n'est pas possible de faire une assignation multiple avec un champ d'une structure union pour le moment.

Partie 4.1:
L'appel de procédure a été réalisé par la création d'une instruction procédure.
Un type TypVoid a été ajouté pour quand le type de retour d'une procédure n'est pas spécifié.
Print et main ont été uniformisés et le code mips va automatiquement appeler la fonction main_int (à cause de la surcharge).
La surcharge a été réalisée en renommant les fonctions avec le type des arguments à la chaine.
La différence entre les conventions est faite avec l'ajout d'un booléen de Source vers Typed.
Les appels terminaux sont détectés dans GotoToFlat et sont distingués par deux instructions et deux expressions en Flat.
Les fonctions ont été modifiées pour lire le premier argument et son type dans a0 et a1 et le deuxième et son type dans a2 et a3.
La valeur de retour et son type sont dans v0 et v1.

Partie 4.2:
Le parser a été légèrement adapté pour que main et les blocs puissent avoir des variables locales.
GotoToFlat, FlatAST et FlatToMips ont été ajoutés pour la représentation trois addresses.
Les 4 premières variables locales d'une fonction et leurs types sont stockés dans les registres t2 à t9.

J'ai tout réalisé par moi-même.

Le preprocessing s'exécute avec l'option -pp
ex : ./compilo -pp test.cid

Les extensions suivantes ne sont plus supportées :
	GotoInterpreter.ml (TP 1.1)
Les autres extensions ont été mises à jour pour supporter les nouvelles constructions du langage
