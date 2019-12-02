const latitude = "37.79"
const longitude = "-122.401"
const altitude = "19.31"
describe("Location test", () => {
    it("should set location to Sauce SF office", () => {

        alert = $("*//XCUIElementTypeAlert")

        if (alert) {
            alertBtn = $("~Allow")
            alertBtn.click()
        }

        browser.setGeoLocation({
            latitude,
            longitude,
            altitude
        })

        locationText = $("~locationText")
        expectedLocation = latitude + ", " + longitude

        expect(locationText.getText()).to.be.equal(expectedLocation)
    })
})