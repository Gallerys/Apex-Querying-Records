trigger UpdateOpportunityOnAccountChange on Account (after update) {
    List<Opportunity> oppsToUpdate = new List<Opportunity>();
    
    for (Account acc : Trigger.new) {
        if (Trigger.oldMap.get(acc.Id).Name != acc.Name) {
            // Find related opportunities and update them
            for (Opportunity opp : [SELECT Id FROM Opportunity WHERE AccountId = :acc.Id]) {
                opp.Name = 'Updated Opportunity Name';
                oppsToUpdate.add(opp);
            }
        }
    }
    
    update oppsToUpdate;
}
