#!/bin/env ruby
# encoding: utf-8
class PopulateRegionTable < ActiveRecord::Migration
  def up
  	Region.create([{ libelle: "Région Alsace - Bas-Rhin"}])
	Region.create([{ libelle: "Région Alsace - Haut-Rhin"}])

	Region.create([{ libelle: "Région Bordeaux - Médoc"}])
	Region.create([{ libelle: "Région Bordeaux - Graves"}])
	Region.create([{ libelle: "Région Bordeaux - Entre-deux-Mers"}])
	Region.create([{ libelle: "Région Bordeaux - Sauternes"}])
	Region.create([{ libelle: "Région Bordeaux - Libourne"}])
	Region.create([{ libelle: "Région Bordeaux - Blaye-Bourg"}])

	Region.create([{ libelle: "Région Beaujolais - Crus du Beaujolais"}])
	Region.create([{ libelle: "Région Beaujolais - Beaujolais Villages"}])
	Region.create([{ libelle: "Région Beaujolais - Beaujolais"}])

	Region.create([{ libelle: "Région Bourgogne - Chablis"}])
	Region.create([{ libelle: "Région Bourgogne - Côte de Nuits"}])
	Region.create([{ libelle: "Région Bourgogne - Côte de Beaune"}])
	Region.create([{ libelle: "Région Bourgogne - Côte chalonnaise"}])
	Region.create([{ libelle: "Région Bourgogne - Mâcon"}])

	Region.create([{ libelle: "Région Champagne - Montagne de Reims"}])
	Region.create([{ libelle: "Région Champagne - Vallée de la Marne"}])
	Region.create([{ libelle: "Région Champagne - Côte des Blancs"}])
	Region.create([{ libelle: "Région Champagne - Côte des Bar"}])
	Region.create([{ libelle: "Région Champagne - Côte de Sézanne"}])
	Region.create([{ libelle: "Région Champagne - Vitry-le-François"}])

	Region.create([{ libelle: "Région Provence-Corse - Provence"}])
	Region.create([{ libelle: "Région Provence-Corse - Corse"}])

	Region.create([{ libelle: "Région Jura - Côtes du Jura"}])
	Region.create([{ libelle: "Région Jura - Arbois"}])

	Region.create([{ libelle: "Région Languedoc-Roussillon - Languedoc"}])
	Region.create([{ libelle: "Région Languedoc-Roussillon - Roussillon"}])

	Region.create([{ libelle: "Région Lorraine - Meuse"}])
	Region.create([{ libelle: "Région Lorraine - Moselle"}])
	Region.create([{ libelle: "Région Lorraine - Toul"}])

	Region.create([{ libelle: "Région Loire - Nantes"}])
	Region.create([{ libelle: "Région Loire - Anjou-Saumur"}])
	Region.create([{ libelle: "Région Loire - Touraine"}])
	Region.create([{ libelle: "Région Loire - Centre"}])
	Region.create([{ libelle: "Région Loire - Auvergne"}])

	Region.create([{ libelle: "Région Rhône - Rhône septentrional"}])
	Region.create([{ libelle: "Région Rhône - Rhône méridional"}])
	Region.create([{ libelle: "Région Rhône - Coteaux du Lyonnais"}])

	Region.create([{ libelle: "Région Savoie-Bugey - Savoie"}])
	Region.create([{ libelle: "Région Savoie-Bugey - Bugey"}])

	Region.create([{ libelle: "Région Sud-Ouest - Bergerac"}])
	Region.create([{ libelle: "Région Sud-Ouest - Cahors"}])
	Region.create([{ libelle: "Région Sud-Ouest - Aveyron"}])
	Region.create([{ libelle: "Région Sud-Ouest - Marmande"}])
	Region.create([{ libelle: "Région Sud-Ouest - Agen"}])
	Region.create([{ libelle: "Région Sud-Ouest - Toulouse"}])
	Region.create([{ libelle: "Région Sud-Ouest - Chalosse"}])
	Region.create([{ libelle: "Région Sud-Ouest - Béarn"}])
	Region.create([{ libelle: "Région Sud-Ouest - Pays Basque"}])
  end

  def down
  	Region..delete_all
  end
end
