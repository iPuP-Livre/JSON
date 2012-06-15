//
//  TableViewController.m
//  JSON
//
//  Created by Marian Paul on 30/03/12.
//  Copyright (c) 2012 iPuP SARL. All rights reserved.
//

#import "TableViewController.h"
#import "Player.h"

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _arrayOfPlayers = [[NSMutableArray alloc] init];
    
    //récupération du chemin vers le fichier contenant le JSON
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"JSON" ofType:@"txt"];
    
    //création d'une data avec le contenu du JSON
    NSData *myJSON = [[NSData alloc] initWithContentsOfFile:filePath];
    
    //Parsage du JSON à l'aide du framework importé
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:myJSON options:0 error:nil];
    
    //récupération  des résultats
    NSDictionary *resultats = [json objectForKey:@"resultats"];
    
    //récupération du tableau de Jouers
    NSArray *listeJoueur = [resultats objectForKey:@"joueurs"];
    
    //On parcourt la liste de joueurs
    for (NSDictionary *dic in listeJoueur) {    
        //création d'un objet Joueur
        Player *player = [[Player alloc] init];
        
        //renseignement du nom
        player.name = [dic objectForKey:@"nom"];
        
        //renseignement du score
        player.score = [[dic objectForKey:@"score"] intValue];
        
        //ajout à la liste
        [_arrayOfPlayers addObject:player];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _arrayOfPlayers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    Player *player = [_arrayOfPlayers objectAtIndex:indexPath.row];
    
    //on affiche le nom et le score
    cell.textLabel.text =  [NSString stringWithFormat:@"%@ - %d",player.name, player.score];
    
    return cell;
}

@end
