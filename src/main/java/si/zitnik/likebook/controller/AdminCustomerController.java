package si.zitnik.likebook.controller;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import si.zitnik.likebook.domain.Customer;
import si.zitnik.likebook.service.CustomerService;

import javax.inject.Inject;
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: slavkoz
 * Date: 5/11/13
 * Time: 2:59 PM
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping("/admin")
@Transactional
public class AdminCustomerController {
    
    @Inject
    private CustomerService customerService;

    @RequestMapping("/customers")
    public String customers(Map<String, Object> map) {
        try {
            map.put("customer", new Customer());
            map.put("customerList", customerService.list());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "admin/customers";
    }

    @RequestMapping("/customers/edit/{customerId}")
    public String customersEdit(Map<String, Object> map, @PathVariable("customerId") Long customerId) {
        try {
            map.put("customer", customerService.get(customerId));
            map.put("customerList", customerService.list());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "admin/customers";
    }

    @RequestMapping(value = "/addCustomer", method = RequestMethod.POST)
    public String addcustomer(@ModelAttribute("customer") Customer customer) {
        try {
            customerService.save(customer);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/admin/customers";
    }


    @RequestMapping("/removeCustomer/{customerId}")
    public String remove(@PathVariable("customerId") Long customerId) {

        customerService.remove(customerId);
        return "redirect:/admin/customers";
    }
}
