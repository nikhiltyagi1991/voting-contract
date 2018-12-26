var Election = artifacts.require('./Election.sol');
contract('Election', function(accounts) {

    // Check if admin is correct
    it('initializes admin', function() {
        return Election.deployed()
            .then(function(instance) {
                return instance.adminUser();
            })
            .then(function(admin) {
                assert.equal(admin, '0x73ead31f91FE56574792AbF60085A6b7a11614A0');
            });
    });
})